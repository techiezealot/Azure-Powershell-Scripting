##Declare variables
$sub = "<insert subscription name>"
$rg = "insert resource group name"
$loc = "ukwinsert location name"
$vnetname = "insert vnet name"
$domainsubname = "insert domain subnet name"
$filesubname = "insert file subnet name"
$appssubname = "insert apps subnet name"
$gwsubname = "GatewaySubnet"
$vnetprefix = "0.0.0.0/00"
$domainsubprefix = "0.0.0.0/00"
$filesubprefix = "0.0.0.0/00"
$appssubprefix = "0.0.0.0/00"
$gwsubprefix = "0.0.0.0/00"
$dns = "8.8.8.8"
$gwname = "insert gateway name"
$gwipname = "insert gateway ip name"
$gwipconfname = "uinserty gateway configuration name"

##Create subnet
$gwsub = New-AzureRmVirtualNetworkSubnetConfig -Name $gwsubname -AddressPrefix $gwsubprefix
$domainsub = New-AzureRmVirtualNetworkSubnetConfig -Name $domainsubname -AddressPrefix $domainsubprefix
$filesub = New-AzureRmVirtualNetworkSubnetConfig -Name $filesubname -AddressPrefix $filesubprefix
$appssub = New-AzureRmVirtualNetworkSubnetConfig -Name $appssubname -AddressPrefix $appssubprefix

##Create new VNet
New-AzureRmVirtualNetwork -Name $vnetname -ResourceGroupName $rg -Location $loc -AddressPrefix $vnetprefix -Subnet $gwsub,$domainsub,$filesub,$appssub

##Request new Gateway IP
$gwpip = New-AzureRmPublicIpAddress -Name $gwipname -ResourceGroupName $rg -Location $loc -AllocationMethod Dynamic

##Create Gateway config
$vnet = Get-AzureRmVirtualNetwork -Name $vnetname -ResourceGroupName $rg
$subnet = Get-AzureRmVirtualNetworkSubnetConfig -Name "GatewaySubnet" -VirtualNetwork $vnet
$gwipconf = New-AzureRmVirtualNetworkGatewayIpConfig -Name $gwipconfname -Subnet $subnet -PublicIpAddress $gwpip

##Create Gateway for VNet
New-AzureRmVirtualNetworkGateway -Name $gwname -ResourceGroupName $rg -Location $loc -IpConfigurations $gwipconf -GatewayType Vpn -VpnType RouteBased -GatewaySku Standard