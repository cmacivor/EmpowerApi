<#
  This script deploys a package in the development-only user profile source to a remote development web server.
  Deployment Config is created here without reference to a CSV file. This is only allowed for dev web sites.
  Application parameters are still referenced from the source-controlled location, so get latest as needed from TFS. 
  
  The application deployed here is: 
  
  Name: EmpowerApp
  Team: Services Team 

  This script requires CorDeploy 0.9.
#>

$applicationName1 = "EmpowerAdult"
$applicationName2 = "EmpowerAdultApi"

$site = "justiceservicesdev"
$appPool = "justiceservices_CommunityServices_4.0"
$DevParamFile1 = "Parameters\Development\CommunityServices\EmpowerAdult.xml"
$DevParamFile2 = "Parameters\Development\CommunityServices\EmpowerAdultApi.xml"


Import-Module CorDeploy

New-CorDeploymentConfig $applicationName1 (Join-Path $WebDeployRoot $DevParamFile1) $site $appPool | Publish-CorWebApp -UseDevPackageSource
New-CorDeploymentConfig $applicationName2 (Join-Path $WebDeployRoot $DevParamFile2) $site $appPool | Publish-CorWebApp -UseDevPackageSource

