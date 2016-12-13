# Project Az (Python-based Azure CLI) Samples - Storage Service - Blobs

Compute Topics:
* [General Storage Management](management.md)
* [Managing Storage Blobs and Containers](blobs.md)
* [Managing Storage Files, Shares, and Directories](files.md)
* [Managing Storage Queues and Messages](queues.md)
* [Managing Storage Tables and Entities](tables.md)

# (Optional) Create a new resource group
When trying new things out, consider creating a new resource group to experiment with:
> Many creation commands will use the resource group's location as a default value.
```
az group create -l westus -n MyRG
```

Here are some useful commands that may help you on your journey
* Delete this RG `az group delete -n MyRG`
* Export to ARM template `az group export -n MyRG > ./MyTemplate.json`

> **NOTE** These examples assume your [connection string](management.md) has been set.

# Managing storage containers

The following commands show how to create and manage containers:
```
az storage container create -n mycontainer
az storage container exists -n mycontainer
az storage container list
az storage container show -n mycontainer
az storge container delete -n mycontainer --fail-not-exist
```

# Managing storage blobs

Upload a new blob
```
az storage blob upload -c mycontainer -f ./MyFile.txt -n MyFile.txt
```

List all blobs in a container
```
az storage blob list -c mycontainer
```

Show a single blob in a container
```
az storage blob show -c mycontainer
```

Check if a blob already exists
```
az storage blob exists -c mycontainer -n MyFile.txt
```

Download a blob
```
az storage blob download -c mycontainer -n MyFile.txt -f ./MyNewFile.txt
```

Delete a blob
```
az storage blob delete -c mycontainer
```
