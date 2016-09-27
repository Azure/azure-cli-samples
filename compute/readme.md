# Project Az (Python-based Azure CLI) Samples - Compute Service

Compute Topics:
* [General](readme.md)
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


# Managing virtual machines

Create a Windows VM
```
az vm create -g MyRG -n MyVM --admin-password "Password123"
```

Or to create a Linux VM.  
> Use tab completion (tab, tab) after --image to see a list of popular images.
```
az vm create -g MyRG -n MyVM --image openSuse
```

You can stop all your VM's at once.  **NOTE** This command applys to **all**
resource groups in your subscription.
```
az vm list --query [].[resourceGroup,name] --out tsv | xargs -L1 bash -c 'az vm stop -g $0 -n $1'

# future target:
# az vm stop $(az vm list --out ids)
```

You can also use xargs to find all running VMs
```
az vm list --query [].[resourceGroup,name] --out tsv | xargs -L1 bash -c 'az vm show -g $0 -n $1 --expand instanceView --query "[resourceGroup, name, instanceView.statuses[1].displayStatus]"'
```

Add a new data disk to an existing VM
```
az vm disk attach-new -g MyRG --vm-name MyVM -n MyNewDisk --lun 0 --vhd 'http://vhdstorage[...].blob.core.windows.net/vhds/newdisk.vhd'
```

You can add a SSH key to a Linux VM
```
az vm access set-linux-user -g mygroup -n myvm -u ops --ssh-key-value ~/.ssh/id_rsa.pub
```
