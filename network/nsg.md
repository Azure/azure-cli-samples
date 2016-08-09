


# Managing network security groups (nsg)

Creating a network security group
```
az network nsg create -g MyRG -n MyNSG 
```

Deleting a network security group
```
az network nsg delete -g MyRG -n MyNSG
```

Describing a network security group (supports `--expand`, see `nic show`)
```
az network nsg show -g MyRG -n MyNSG
```

Listing all network security groups
```
az network nsg list-all
```

Listing all network security group in a resource group
```
az network nsg list -g MyRG
```

# Managing network security group rules

Creating a rule, in this case for outbound HTTP traffic
```
az network nsg rule create -g MyRG -n ALLOW-HTTP-INTERNET-OUTBOUND --nsg-name MyNSG \
   --access allow --direction outbound --protocol tcp \ 
   --destination-address-prefix 'internet' --destination-port-range 80 \
   --source-address-prefix '*' --source-port-range 80 \
   --description "Allow outbound HTTL traffic from all VMs to Internet' 
```

Deleting a rule
```
az network nsg rule delete -g MyRG -n ALLOW-HTTP-INTERNET-OUTBOUND --nsg-name MyNSG
```

Describing a rule
```
az network nsg rule show -g MyRG -n ALLOW-HTTP-INTERNET-OUTBOUND --nsg-name MyNSG
```

Listing all rule
```
az network nsg rule list -g MyRG --nsg-name MyNSG
```
