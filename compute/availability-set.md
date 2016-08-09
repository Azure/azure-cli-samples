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


# Working with Availability Sets

The follow script creates an example availability set with two machines
attached to a load balancer.  
> The difference between an **availability set** and **load balancer**:

>**Availability sets** ensure that contained resources are managed "behind the scenes", such as ensuring resources avoid single points of failure.  
> **Load balancers** ensure
that incoming network traffic gets routed to multiple machines for processing.

```

az network vnet create -g MyRG -n VNET1
az network vnet subnet create -g MyRG --vnet VNET1 -n S1
az network public-ip create -g MyRG -n IP1 --allocation-method static --dns-name MyDNS

az network lb create -g MyRG -n LB1 --frontend-ip-name LBFE --backend-pool-name LBBE

az network lb inbound-nat-rule create -g MyRG -n SSH1 --lb-name LB1 --backend-port 22 \
     --frontend-port 21 --frontend-ip-name LBFE --protocal tcp
az network lb inbound-nat-rule create -g MyRG -n SSH2 --lb-name LB1 --backend-port 22 \
     --frontend-port 23 --frontend-ip-name LBFE --protocal tcp

az network lb probe create -g MyRG -n HTTPPROBE --lb-name LB1 --port 80 --protocol tcp

az network lb rule create -g MyRG -n HTTP1 --lb-name MyLB --probe-name HTTPPROBE --protocal tcp \
     --frontend-ip-name LBFE  --frontend-port 80 \
     --backend-pool-name LBBE --backend-port 80

az network lb rule create -g MyRG -n HTTP2 --lb-name MyLB --probe-name HTTPPROBE --protocal tcp \
     --frontend-ip-name LBFE  --frontend-port 1234 \
     --backend-pool-name LBBE --backend-port 8000

az network lb show -g MyRG -n LB1

az network nic create -g MyRG -n NIC1 --subnet-name S1 --vnet-name VNET1 \
     --lb-address-pool-ids '/subscriptions/[...]/resourceGroups/MyRG/providers/Microsoft.Network/loadBalancers/LB1/backendAddressPools/LBBE' \
     --lb-nat-rule-ids '/subscriptions/[...]/resourceGroups/MyRG/providers/Microsoft.Network/loadBalancers/LB1/inboundNatRules/ssh1'

az network nic create -g MyRG -n NIC2 --subnet-name S1 --vnet-name VNET1 \
     --lb-address-pool-ids 'LBBE' \
     --lb-nat-rule-ids 'ssh1'

az vm availability-set create -g MyRG -n AS1

az vm create -g MyRG -n VM1 --availability-set AS1 --vnet VNET1 --subnet S1 --nic NIC1
az vm create -g MyRG -n VM2 --availability-set AS1 --vnet VNET1 --subnet S1 --nic NIC2

```
