# Project Az (Python-based Azure CLI) Samples - Storage Service - Files

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
az resource group create -l westus -n MyRG
```

Here are some useful commands that may help you on your journey
* Delete this RG `az resource group delete -n MyRG`
* Export to ARM template `az resource group export -n MyRG > ./MyTemplate.json`

> **NOTE** These examples assume your [connection string](management.md) has been set.

Files management in Azure Storage consists of Shares, Directories, and Files with
each having their own group in the Azure CLI 2.0.

# Managing storage shares
Shares are the outer-most container for file storage.

Creating and managing a share
```
az storage share create -n myshare
az storage share list
az storage share show -n myshare
az storage share exists -n myshare
az storage share delete -n myshare
```

# Managing storage directories
Shares are file container that is contained within a share.  

Creating and managing directories
```
az storage directory create -s myshare -n MyDirectory
az storage directory show -s myshare -n MyDirectory
az storage directory exists -s myshare -n MyDirectory
az storage directory delete -s myshare -n MyDirectory
```

Listing files in a directory
```
az storage file list -s myshare -p MyDirectory
```

# Managing storage files
Files represent individual file entities in a Share or Directory.

Upload a new file to a share or directory
```
az storage file upload -s myshare --source ./MyFile.txt
az storage file upload -s myshare --source ./MyFile.txt -p MyDirectory
```

List all files in a share or directory
```
az storage file list -s myshare
az storage file list -s myshare -p MyDirectory
```

Show a single file in a share or directory
```
az storage file show -s myshare
az storage file show -s myshare -p MyDirectory
```

Check if a file already exists
```
az storage file exists -s myshare -p 'MyFile.txt'
az storage file exists -s myshare -p 'MyDirectory/MyFile.txt'
```

Resize a file (via truncation)
```
az storage file resize -s myshare -p 'MyFile.txt' --size  -n 1000000
az storage file resize -s myshare -p 'MyDirectory/MyFile.txt' --size  -n 1000000
```

Download a file
```
az storage file download -s myshare -p MyFile.txt --dest ./MyNewFile.txt
az storage file download -s myshare -p MyDirectory/MyFile.txt --dest ./MyNewFile.txt
```

Delete a file
```
az storage file delete -s myshare -p 'MyFile.txt'
az storage file delete -s myshare -p 'MyDirectory/MyFile.txt'
```
