##Azure Resource Group Creation Script
##
## Set the Resource Group name
$RGName = Read-Host -Prompt "Resource Group Name"
##Set the Resource Group location
$RGLocation = Read-Host -Prompt "Resource Group Location"

New-AzureRMResourceGroup -Name $RGName -Location $RGLocation -Tag $RGTag