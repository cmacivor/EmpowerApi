<#
  .SYNOPSIS
  This script builds and packages a .NET web application so that it may be deployed to a remote web server.
  
  .DESCRIPTION
  See script variables below for updates required to package your application.  

  Requirements
  ------------
  (1) The target project must be Visual Studio 2015.
  (2) The target project should be a Web Application Project (not a Web Site Project).
  (3) The target project must contain Richmond deployment artifacts as defined in the ASD deployment guidance document.
      This includes a Release build configuration, ReleasePackage.pubxml, and usually a parameters.xml file.
#>

# Update MSBuild ProjectFile (REQUIRED). This may be the only variable you need to update. 
# The path provided here must identify a Visual Studio project or solution file. 
# This may be a relative path that follows Visual Studio path rules. 
# 
$ProjectFile = "..\DJSCaseMgtWeb\DJSCaseMgtWeb.csproj"

# Update MSBuild Properties as needed. Sample value specifies:
#  (1) Release build for tokenizing environment variables and other transformations,
#  (2) DeployOnBuild to specify Web Deploy package generation,  
#  (3) A publish profile named "ReleasePackage" that defines the package output path, and
#  (4) Visual Studio 2015. 
$Properties = "/p:Configuration=Release;PublishProfile=JuvenilePackage;DeployOnBuild=True;VisualStudioVersion=14.0"

# Update MSBuild Target as needed. This argument may often be omitted. 
# The value shown here forces a rebuild (instead of a build) on the project named CityworksFacade.WebServiceHost.csproj.
# Create a ".sln.metaproj" file to inspect target names assigned during the build process.
#$Target = "/t:DJSCaseMgtWeb:Rebuild" 

# Update the system %PATH% to MSBuild.exe as needed.
$env:Path += ";C:\Program Files (x86)\MSBuild\14.0\Bin"

# Call MSBuild.
MSBuild.exe $ProjectFile $Properties #$Target
