# Project Az (Python-based Azure CLI) Samples - Storage Service - Queues

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
* Delete this RG `az resource group delete -n MyRG`
* Export to ARM template `az resource group export -n MyRG > ./MyTemplate.json`

> **NOTE** These examples assume your [connection string](management.md) has been set.

# Managing queues
The queue service provides reliable messaging for workflow processing and
communication between loosely coupled components of cloud services.

Managing Queues
```
az storage queue create -n myqueue
az storage queue list
az storage queue exists -n myqueue
az storage queue delete -n myqueue
```

# Managing queue messages

Adding messages to the queue
```
az storage message put -q myqueue --content "test content 1"
```

Reading messages on the queue
```
# Retrieves a message, but does not alter the message or queue
az storage message peek -q myqueue
```

Processing a message on the queue
```
# JSON output required per [#1003](https://github.com/Azure/azure-cli/issues/1003)
az storage message get -q myqueue --out json
[
  {
    "content": "test content 2",
    "dequeueCount": 1,
    "expirationTime": "2016-10-04T21:10:33+00:00",
    "id": "f4753512-b461-4ec9-9d7c-9581d2b971b4",
    "insertionTime": "2016-09-27T21:10:33+00:00",
    "popReceipt": "AgAAAAMAAAAAAAAAqGAiqQMZ0gE=",
    "timeNextVisible": "2016-09-27T21:11:06+00:00"
  }
]

# Do Work Here

az storage message delete -q myqueue --id 'f4753512-b461-4ec9-9d7c-9581d2b971b4' --pop-receipt 'AgAAAAMAAAAAAAAAqGAiqQMZ0gE=' --out json
```

Removing messages from the queue
```
az storage message clear -q myqueue
```
