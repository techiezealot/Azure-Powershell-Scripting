##Declare Variables
$UKGWName1 = "AUK-NET-GW01"
$WEGWName1 = "AWE-NET-GW01"
$RG1 = "UKWestRG"
$RG2 = "WestEuropeRG"
$connectionukwe = "ukvnet1towevnet1"
$connectionweuk = "wevnet1toukvnet1"
$UKLocation = "ukwest"
$WELocation = "westeurope"

##Get virtual network gateways to connect
$ukvnetgw1 = Get-AzureRmVirtualNetworkGateway -Name $UKGWName1 -ResourceGroupName $RG1
$wevnetgw1 = Get-AzureRmVirtualNetworkGateway -Name $WEGWName1 -ResourceGroupName $RG2

##Create the ukvnet to wevnet connection
New-AzureRmVirtualNetworkGatewayConnection -Name $connectionukwe -ResourceGroupName $RG1 -VirtualNetworkGateway1 $ukvnetgw1 -VirtualNetworkGateway2 $wevnetgw1 -Location $UKLocation -ConnectionType Vnet2Vnet -SharedKey "Azure5h4r3dk3y"

##Create the wevnet to ukvnet connection
New-AzureRmVirtualNetworkGatewayConnection -Name $connectionweuk -ResourceGroupName $RG2 -VirtualNetworkGateway1 $wevnetgw1 -VirtualNetworkGateway2 $ukvnetgw1 -Location $WELocation -ConnectionType Vnet2Vnet -SharedKey "Azure5h4r3dk3y"
