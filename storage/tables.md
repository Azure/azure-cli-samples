# Project Az (Python-based Azure CLI) Samples - Storage Service - Tables

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

# Managing tables

The following commands show how to create and manage tables:
```
az storage table create -n MyTable
az storage table list
az storage table exists -n MyTable
az storge table delete -n MyTable --fail-not-exist
```

# Managing queue messages

To insert a new entity into a table, you have to define a set of key-value pairs
separated by spaces.  You must include both `PartitionKey` and `RowKey` pairs as
these combine to act as your primary key.
```
az storage entity insert -t MyTable -e PartitionKey=AAA RowKey=BBB Content=ASDF1
```

You can replace an existing entity by using the `replace` verb and provide the
`PartitionKey` and `RowKey` of the entity you wish to replace.
```
az storage entity replace -t MyTable -e PartitionKey=AAA RowKey=BBB Content=ASDF2
```

You can also update an existing entity with the `merge` command and provide the
`PartitionKey` and `RowKey` of the entity you wish to modify.  Provided key-value
pairs are added, overwriting existing values if found.
```
az storage entity merge -t MyTable -e PartitionKey=AAA RowKey=BBB Content2=qwerty
```

To see the current state of an entity, use `Show`.
```
az storage entity show -t MyTable --partition-key AAA --row-key BBB
```

Or find entities using OData expressions.
```
az storage entity query -t MyTable --filter "PartitionKey eq 'AAA'"
```

Finally, to delete an entity, pass its keys to the `delete` command.
```
az storage entity delete -t MyTable --partition-key AAA --row-key BBB
```
