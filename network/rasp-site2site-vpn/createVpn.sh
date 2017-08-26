azp="/home/pi/bin"       #Path to Azure CLI binaries. Change if you didn't install at the default location
echo -n "Please type the Shared Key:"
read sharedKey

echo $sharedKey

#Retrieve local network information
activeInterface=$(ip route get 8.8.8.8 | awk '{print $5; exit}')
activeSubnet=$(ip route | grep $activeInterface | grep kernel | awk '{print $1; exit}')
leftip=$(ip route | grep $activeInterface | grep kernel | awk '{print $9; exit}') 
localGatewayIpAddress=$(curl ifconfig.me) # enternal network address if behind a NAT


resGroup="GWS2SRasp"        # Resource group name
location='Central US'   # AZR Region to deploy the gateway
vpnType='RouteBased'
localGatewayName='home'
localAddressPrefix=$activeSubnet
virtualNetworkName='azureVNet'
azureVNetAddressPrefix="10.3.0.0/16"
subnetName='Subnet1'
subnetPrefix='10.3.0.0/24'
gatewaySubnetPrefix="10.3.254.0/29"
gatewayName="azrGateway"
gatewaySku="Basic"
connectName="AzureToHome"
vmName="pingTest"
vmSize="Standard_A1"
adminUserName="ubuntu"

# Hack to randomize the storage account name
storageAccountName=$(cat /proc/sys/kernel/random/uuid | md5sum)
storageAccountName="${storageAccountName:1:23}" 

storageAccountType="Standard_LRS"

#Parameters to deploy the Azure site to site ARM template
params="{\"vpnType\":{\"value\":\"$vpnType\"},\"localGatewayName\":{\"value\":\"$localGatewayName\"},\"adminUsername\":{\"value\":\"$adminUserName\"},\"localGatewayIpAddress\":{\"value\":\"$localGatewayIpAddress\"},\"localAddressPrefix\":{\"value\":\"$localAddressPrefix\"},\"azureVNetAddressPrefix\":{\"value\":\"$azureVNetAddressPrefix\"},\"subnetPrefix\":{\"value\":\"$subnetPrefix\"},\"gatewaySubnetPrefix\":{\"value\":\"$gatewaySubnetPrefix\"},\"newStorageAccountName\":{\"value\":\"$storageAccountName\"},\"sharedKey\":{\"value\":\"$sharedKey\"}}"

echo "Please follow the instructions to login"
echo "If the script is run over a SSH connection, you can open the browser locally"
$azp/az login

$azp/az group create --name "$resGroup" --location "$location"
res=$?

$azp/az group deployment create \
    --name ExampleDeployment \
    --resource-group "$resGroup" \
    --template-uri "https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/201-site-to-site-vpn/azuredeploy.json" \
    --parameters $params
res=$(( $res + $? ))

#Get the IP Address from the create AZR VPN Gateway
# jq is used to parse the json results 
id=$($azp/az network  vnet-gateway list --resource-group $resGroup | jq -r '.[].ipConfigurations[].publicIpAddress.id')
res=$(( $res + $? ))
ip=$($azp/az network public-ip list --resource-group $resGroup | jq -r '.[] | select(.id=="'$id'") | .ipAddress')
res=$(( $res + $? ))
rightSubnet=$($azp/az network vnet list --resource-group $resGroup | jq -r ".[].addressSpace.addressPrefixes[0]")
res=$(( $res + $? ))

if [ $res -ne 0 ] 
then
    echo "Something went wrong... exiting"
    exit $res
else
    echo "Everything went well... Configuring strongSwan"
fi


secret="'$sharedKey'"
echo $ip



swann="conn home-to-azure
        closeaction=restart
        dpdaction=restart
        ike=aes256-sha1-modp1024
        esp=aes256-sha1
        reauth=no
        keyexchange=ike
        mobike=no
        ikelifetime=28800s
        keylife=3600s
        keyingtries=%forever
        authby=secret
        left=$leftip            # local instance ip (strongswan)
        leftsubnet=$activeSubnet
        leftid=$leftip         # local instance ip (strongswan)
        right=$ip
        rightid=$ip      # vpn gateway ip (azure)
        rightsubnet=$rightSubnet      # private ip segment (azure)
        auto=route"

sudo -s -- <<EOF
	echo "$swann" >> /etc/ipsec.conf
EOF


#ip secrets 
ipscr="$leftip $ip : PSK $secret"
sudo -s -- <<EOF
	echo "$ipscr" >> /etc/ipsec.secrets
EOF

echo Restarting IPSec...
sudo ipsec restart 
