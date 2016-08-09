>> This page is a work in progress and is not accurate


# Managing application gateway

Create an application gateway
> not supported yet

Delete an application gateway
```
az network application-gateway delete -g MyRG -n MyGateway
```

List all application gateways in a resource group
```
az network application-gateway list -g MyRG
```

List all application gateways
> This command will be folded into `list`
```
az network application-gateway list-all
```

Describe an application gateway
```
az network application-gateway show -g MyRG -n MyGateway
```

Start an application gateway
```
az network application-gateway start -g MyRG -n MyGateway
```

Stop an application gateway
```
az network application-gateway stop -g MyRG -n MyGateway
```

# Managing local gateway

List local gateways in a resource group
```
az network local-gateway list -g MyRG
```

Describe local gateway
```
az network local-gateway show -g MyRG -n MyGateway
```

Delete local gateway
```
az network local-gateway delete -g MyRG -n MyGateway
```
