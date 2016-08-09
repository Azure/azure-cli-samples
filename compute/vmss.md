# Project Az (Python-based Azure CLI) Samples - Compute Service

Compute Topics:
* [General](compute.md)
* [Managing ScaleSets](vmss.md)
* [Managing Availability Sets](availability-set.md)
* [Managing Azure Container Services](container-service.md)

# (Optional) Create a new resource group 
When trying new things out, consider creating a new resource group to experiment with:
> Many creation commands will use the resource group's location as a default value. 
```
az resource group create -l westus -n MyRG
```

Here are some useful commands that may help you on your journey
* Delete this RG `az resource group delete -n MyRG`
* Export to ARM template `az resource group export -n MyRG > ./MyTemplate.json`

# Managing Azure virtual machine scale sets (VMSS)

create a new virtual machine scale set
```
az vm scaleset create -g mygroup -n MyScaleSet --image opensuse --instance-count 3
```

get a list of all scale sets
```
az vm scaleset list -g MyGroup
```

get a list of all VMs in a scale set
```
az vm scaleset list-instances -g MyGroup -n MyScaleSet 
```

show a VM in a scale set
```
az vm scaleset show-instance -g MyGroup -n MyScaleSet --instance-id 0
```

stop two vms
```
az vm scaleset stop -g MyGroup -n MyScaleSet --instance-ids 0 2
```
stop all vms in a scale set
```
az vm scaleset stop -g MyGroup -n MyScaleSet
```