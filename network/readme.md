# Managing virtual networks (vnet)


## Managing subnets
Subnets are a sub-resource of a virtual network.  


# Managing network interfaces (nic)

Creating a network interface
```
az network nic -g MyRG -n MyNic --subnet-name MyVnetSubnet --vnet-name MyVnet
```

Deleting a network interface
```
az network nic -g MyRG -n MyNic
```

Describing a network interface
```
az network nic show -g MyRG -n MyNic
```

Use the `--expand` to expand another network reference in the same operation
such as this query to show network security group rules that apply to a nic
```
az network nic show -g MyRG -n MyNic --expand networkSecurityGroup --query networkSecurityGroup.defaultSecurityRules[].[name,description]
[
  [
    "AllowVnetInBound",
    "Allow inbound traffic from all VMs in VNET"
  ],
  [
    "AllowAzureLoadBalancerInBound",
    "Allow inbound traffic from azure load balancer"
  ],
  [
    "DenyAllInBound",
    "Deny all inbound traffic"
  ],
  [
    "AllowVnetOutBound",
    "Allow outbound traffic from all VMs to all VMs in VNET"
  ],
  [
    "AllowInternetOutBound",
    "Allow outbound traffic from all VMs to Internet"
  ],
  [
    "DenyAllOutBound",
    "Deny all outbound traffic"
  ]
]
```

or if you like GREP, use `--out tsv`
```
az network nic show -g MyRG -n MyNic --expand networkSecurityGroup --query networkSecurityGroup.defaultSecurityRules[].[name,description] --out tsv
AllowVnetInBound        Allow inbound traffic from all VMs in VNET
AllowAzureLoadBalancerInBound   Allow inbound traffic from azure load balancer
DenyAllInBound  Deny all inbound traffic
AllowVnetOutBound       Allow outbound traffic from all VMs to all VMs in VNET
AllowInternetOutBound   Allow outbound traffic from all VMs to Internet
DenyAllOutBound Deny all outbound traffic
```

Listing all network interfaces
```
az network nic list-all
```

Listing all network interfaces in a resource group
```
az network nic list -g MyRG
```

# Managing public IP address

Creating a public ip address
```
az network public-ip -g MyRG -n MyNic --dns-name 'echo-thunder'
```

Deleting a public ip address
```
az network public-ip -g MyRG -n MyNic
```

Describing a public ip address (supports --expand, see `nic`)
```
az network public-ip show -g MyRG -n MyNic
```

Listing all public ip address
```
az network public-ip list-all
```

Listing all public ip address in a resource group
```
az network public-ip list -g MyRG
```
