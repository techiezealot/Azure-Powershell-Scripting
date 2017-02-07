## Azure Resource Group Creation Script
##
## A basic script that outputs Azure datacentre locations, declares variables by user prompt and creates resource groups depending on the input
##
## -----------------------------------------------------------------------------------------------------------
##
## Set the Resource Group name
$RGName = Read-Host -Prompt "Please enter the desired Resource Group Name"
## List the available Azure locations
Get-AzureRMLocation | fl Location
##Set the Resource Group location
$RGLocation = Read-Host -Prompt "Please enter the desired Resource Group Location"

New-AzureRMResourceGroup -Name $RGName -Location $RGLocation -Tag $RGTag