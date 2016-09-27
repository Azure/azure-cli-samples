# Project Az (Python-based Azure CLI) Samples - Storage Service

Compute Topics:
* [General Storage Management](readme.md)
* [Managing Storage Blobs and Containers](blobs.md)
* [Managing Storage Files, Shares, and Directories](files.md)
* [Managing Storage Queues and Messages](queues.md)
* [Managing Storage Tables and Entities](tables.md)

# (Optional) Create a new resource group
When trying new things out, consider creating a new resource group to experiment with:
> Many creation commands will use the resource group's location as a default value.
```
az resource group create -l westus -n MyRG
```

Here are some useful commands that may help you on your journey
* Delete this RG `az resource group delete -n MyRG`
* Export to ARM template `az resource group export -n MyRG > ./MyTemplate.json`

# Working with storage accounts
Before you can start using the storage service, you will first need to setup your
storage account and set your connection string.  

```
az storage account create -g MyRG -n DemoSA -l westus --type Standard_LRS
```

You can view the newly created account with the following commands:

```
az storage account show -g MyRG -n DemoSA
az storage account list -g MyRG -n DemoSA
```

To save a storage account as your default:
```
   MyConectionString=$(az storage account show-connection-string -g MyRG -n DemoSA)

   # Saves for the current session
   export AZURE_STORAGE_CONNECTION_STRING="$MyConnectionString"
```
> You can set your AZURE_STORAGE_CONNECTION_STRING in your shell login
> script, such as `.bash_profile` in OSX.  The remaining Storage Samples
> assume this has been set.

You can manage your connection string keys with the following commands
```
az storage account keys list -g MyRG -n DemoSA
az storage account keys renew -g MyRG -n DemoSA --key primary
```

You can update some properties of your storage account
```
az storage account update -g MyRG -n DemoSA --sku Standard_ZRS
```

You can delete a storage account using
```
az storage account delete -g MyRG -n DemoSA
```
