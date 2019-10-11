<#
  .SYNOPSIS
  Creates a new Web Deploy package for deploying the following ASP.NET web application:

    Address Map - MVC 5 release
  
  .DESCRIPTION
  This script should be used to build and package the application named above. Packaging is a pre-requisite for
  all application deployment to Richmond web servers, including dev environments. 
  
  This function calls MSBuild.exe with arguments that: 
  
  (1) set the Release build for tokenizing environment variables and other transformations,
  (2) flag DeployOnBuild to specify Web Deploy package generation,  
  (3) reference a publish profile named "ReleasePackage" that defines the package output path, and
  (4) reference Visual Studio 2015. 
     
  The publish profile should define an expression like the following to uniquely identify the build and ensure 
  that outputs are never overwritten (be sure to replace "HelloWorld" with an application name unique across the 
  DIT Applications Inventory):
  
  $(UserProfile)\Documents\WebDeploy\Packages\build.$([System.DateTime]::Now.ToString("yyyy.MM.dd.HHmmss"))\HelloWorld.zip
    
  Note
  ----
  This script is intentionally excluded from CorDeploy because: 
  (1) the function below does nothing more than pass arguments to msbuild, and 
  (2) developers will need to modify msbuild arguments in unexpected ways.
  
  Requirements
  ------------
  (1) The target project must be Visual Studio 2015.
  (2) The target project should be a Web Application Project (not a Web Site Project).
  (3) The target project must contain Richmond deployment artifacts as defined in the ASD deployment guidance document.
      This includes a Release build configuration, ReleasePackage.pubxml, and usually a parameters.xml file.
  (4) As written here, msbuild.exe must be in the PATH environmental variable.

  .PARAMETER ProjectFile
  A path to the project or solution file to be supplied as the MSBuild ProjectFile argument. This may be a relative 
  path that follows Visual Studio path rules.
  
  .PARAMETER Rebuild
  A switch to force a rebuild of the project file or solution.
  
  .EXAMPLE
  New-DotNetPackage "..\HelloWorld.sln" -rebuild
  
  Description
  -----------
  The above command rebuilds and packages the HelloWorld solution. 
#>
function New-DotNetPackage{
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $True, ValueFromPipeline = $True)][string]$ProjectFile,
    [Switch]$Rebuild = $False
  )
  Process {
    $argument = ('"{0}" /p:Configuration=Release;PublishProfile=ReleasePackage;DeployOnBuild=True;VisualStudioVersion=14.0' -f $ProjectFile)
    if ($Rebuild){
      $argument = $argument + " /t:rebuild"
    }
    msbuild $argument
  }
}

New-DotNetPackage '..\DJSCaseMgtWeb\DJSCaseMgtWeb.csproj' -Rebuild
