# Project Az (Python-based Azure CLI) Samples - Role-based Access Control (RBAC)

Topics:
* [General](rbac.md)

# (Optional) Create a new resource group 
When trying new things out, consider creating a new resource group to experiment with:
> Many creation commands will use the resource group's location as a default value. 
```
az group create -l westus -n MyRG
```

Here are some useful commands that may help you on your journey
* Delete this RG `az resource group delete -n MyRG`
* Export to ARM template `az resource group export -n MyRG > ./MyTemplate.json`

# Managing with Azure Role-based Access Control (RBAC)

## Example role config
```
 {
     "Name": "Contoso On-call",
     "Description": "Can monitor compute, network and storage, and restart virtual machines",
     "Actions": [
       "Microsoft.Compute/*/read",
       "Microsoft.Compute/virtualMachines/start/action",
       "Microsoft.Compute/virtualMachines/restart/action",
       "Microsoft.Compute/virtualMachines/downloadRemoteDesktopConnectionFile/action",
       "Microsoft.Network/*/read",
       "Microsoft.Storage/*/read",
       "Microsoft.Authorization/*/read",
       "Microsoft.Resources/subscriptions/resourceGroups/read",
       "Microsoft.Resources/subscriptions/resourceGroups/resources/read",
       "Microsoft.Insights/alertRules/*",
       "Microsoft.Support/*"
     ],
     "AssignableScopes": ["/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx","/subscriptions/yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy"]
```

Create a role
```
az role create --config <file or json string>
```

Show role details
```
$ az role show -n "Contoso On-call"
```

Modify / sdd rights to the role
```
az role set --config <file or json string>
```

Assign a role to user on a subscription 
```
az role assignment create --assignee john.doe@contoso.com --role Reader
```

Assign a role to a service principal on a resource group
```
az role assignment create --assignee http://cli-login --role contributor --resource-group teamGroup
```

List all users and their rights for a virtual machine
```
az role assignment list --resource-id /subscriptions/[...]/resourceGroups/myadfs/providers/Microsoft.Compute/virtualMachines/myadfs
```

List all virtual machines a user has rights to
```
az resource list --resource-group MyRG --resource-type "Microsoft.Compute/virtualMachines" --query "[].permissions" -o tsv | grep `$whoami`
```

Remove a role of a user on a resource group or resource or subscription
```
az role assignment delete --assignee john.doe@contoso.com --role Contributor -g teamGroup
```

Delete a role definition
```
az role delete -n "Contoso On-call"
```
