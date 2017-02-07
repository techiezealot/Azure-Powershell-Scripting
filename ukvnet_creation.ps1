##Declare variables
$sub = "Free Trial"
$rg = "UKWestRG"
$loc = "ukwest"
$vnetname = "ukvnet1"
$domainsubname = "Domain"
$filesubname = "File"
$appssubname = "Apps"
$gwsubname = "GatewaySubnet"
$vnetprefix = "10.64.0.0/16"
$domainsubprefix = "10.64.1.0/24"
$filesubprefix = "10.64.2.0/24"
$appssubprefix = "10.64.3.0/24"
$gwsubprefix = "10.64.255.0/27"
$dns = "8.8.8.8"
$gwname = "AUK-NET-GW01"
$gwipname = "ukvnet1gw"
$gwipconfname = "ukvnet1gwconf"
$connectionukwe = "ukvnet1towevnet1"

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