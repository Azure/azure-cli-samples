# Project Az (Python-based Azure CLI) Samples - ARM Service

Topics:
* [General](arm.md)

# (Optional) Create a new resource group 
When trying new things out, consider creating a new resource group to experiment with:
> Many creation commands will use the resource group's location as a default value. 
```
az group create -l westus -n MyRG
```

Here are some useful commands that may help you on your journey
* Delete this RG `az resource group delete -n MyRG`
* Export to ARM template `az resource group export -n MyRG > ./MyTemplate.json`


# Managing Azure resources 

Delete a resource generically
```
az resource  delete -g MyRG --resource-type "Microsoft.Network/virtualNetworks" -n MyExampleVnet
```

Export a resource group and create a new group using the template
```
az resource group list
[...]

az resource group export -n MyRG > ~/MyTemplate.json

cat ~/MyTemplate.json
[...]

az resource group deployment create --template-file-path ~/MyTemplate.json -g oDemo
[...]

az resource group list --query "[?name=='oDemo']"
```

# Managing and working with tags

Create a new tag
```
az tag create -n Owner -v Accounting
```

Tag a vm with the new tag
```
az vm set -g MYRG -n MYVM --set-tag Owner=Accounting
```

Update a tag with a new value
```
az vm set -g MyRG -n MYVM --set-tag Owner=R/&D
```

Tag a vm with multiple tags in a single operation
```
az vm set -g MyRG -n MyVM --set-tag Display="Home Office" Owner=Accounting
```

List all resource with the new tag and value
```
az resource list --tag Owner=Accounting
```

List all VMs with the new tag and value
```
az vm list --tag Owner=Accounting
```

List all resource with the new tag
```
az resource list --tag Owner
```

List all VMs with the new tag
```
az vm list --tag Owner
```

Set a tag to an empty string
```
az vm set -g MYRG -n MYVM --set-tag Owner
```

Remove the tag from the vm
```
az vm set -g MYRG -n MYVM --remove-tag Owner
```

Clear all tags from a VM
```
az vm set -g MYRG -n MYVM --remove-tag *
```

List all tags in a subscription
```
az tag list
```

Remove all instances of a tag
```
az tag delete -n Owner
```

Create a new generic resource with a tag
```
az resource create [...] --set-tag Owner=Accounting
```

Update a generic resource with a tag
```
az resource set [...] --set-tag Owner=Accounting
```

# Managing resource providers

Register a new resource provider
```
az resource provider register -n "Microsoft.ApiManagement"
```

Unregister a resource provider
```
az resource provider unregister -n "Microsoft.ApiManagement"
```

Example query for locations that support a given resource provider
```
az resource provider list --query "[?namespace=='Microsoft.ApiManagement'].[resourceTypes[].locations[*]]" | grep '"'
```

Example query for usage and usage limits on a resource provider
>Note: To develop, see https://github.com/Azure/azure-cli/issues/556
```
az usage list "07/01/2016" "07/02/2016" | grep "Storage"
```


