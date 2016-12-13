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
az group create -l westus -n MyRG
```

Here are some useful commands that may help you on your journey
* Delete this RG `az resource group delete -n MyRG`
* Export to ARM template `az resource group export -n MyRG > ./MyTemplate.json`


# Managing Azure Container Service (ACS)
This command will create a new container service for either Docker Swarm or DCOS

```
# Using DCOS - default
az vm container create -g MyRG -n ACS1 --dns-name-prefix acsdemo

# Using Docker Swarm
az vm container create -g MyRG -n ACS1 --dns-name-prefix acsdemo --orchestrator-type Swarm

# Use SSH into jumpbox and use Swarm or DCOS (Mesos, Marathon) tooling
```
