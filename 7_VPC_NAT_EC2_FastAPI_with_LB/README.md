1. Create below system through AWS first , later provide all kind of roles/IAMs
   - ![SystemDesign1](imgs/image-SystemDesignDiag.drawio.svg)
1. VPC Creation
1. Create 2 VM in 2 different AZ (private Subnet)
1. Create 1 more Bation Host / Jump Server in one Public Subnet inside the same VPC to access the other two **VMs**.
1. Create Target Group for these 2 private VM.
1. Create load balancer for 2 az for that created target group.
1. Requirement : docker should be installed in those two private VMs

   - So need to create a **NAT Gateway in public subnet** of the VPC.
   - That public subnet should be having connection to internet through internet gateway of VPC.
   - add **route rule** for private subnet to route internet traffic via Nat gateway to the VMs so that we can **install Docker on VM** and pull the imgs/image to deploy.

1. Before NatGate was there
1. ![NatGateWayCreationSS](imgs/image.png)

1. After natgate creation:

   > ![NatGateCreated](imgs/image-1.png)

1. Make entry in Route table for Private Subnets to connect natgate for internet access.

1. ![RouteTableEntryEdit](imgs/image-2.png)
1. ![AddNewRouteRule](imgs/image-3.png)
1. Check VPC flow diag.
   - ![forVm1NatGateSet](imgs/image-4.png)
1. Now repeat same for the other vm in other AZ
   - ![forVm2NatGateSet](imgs/image-5.png)
1. Now both VM can ping to internet.
   - ![VmConnectedToInternet](imgs/image-6.png)
   - ![DokerContainerRunning](imgs/image-7.png)
1. Target Group for Vm1 and VM2 in Private Subnet :
   - ![TargetGroup](imgs/image-8.png)
1. Load Balancer (working):
   - ![LoadBalancerWorkingProperly](imgs/image-9.png)
1. Hosted App and the log for both VM:
   - ![FastAPI_WebApp](imgs/image-10.png)
   - ![LogsForBothVMToShowCaseLoadBalancing](imgs/image-logs.jpg)
