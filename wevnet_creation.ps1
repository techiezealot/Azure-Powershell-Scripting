##Declare variables
$sub = "Free Trial"
$rg = "WestEuropeRG"
$loc = "westeurope"
$vnetname = "wevnet1"
$domainsubname = "Domain"
$filesubname = "File"
$appssubname = "Apps"
$gwsubname = "GatewaySubnet"
$vnetprefix = "10.128.0.0/16"
$domainsubprefix = "10.128.1.0/24"
$filesubprefix = "10.128.2.0/24"
$appssubprefix = "10.128.3.0/24"
$gwsubprefix = "10.128.255.0/27"
$dns = "8.8.8.8"
$gwname = "AWE-NET-GW01"
$gwipname = "wevnet1gw"
$gwipconfname = "wevnet1gwconf"
$connectionukwe = "wevnet1toukvnet1"

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