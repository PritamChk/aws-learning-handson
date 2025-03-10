## Create custom VPC & Use in EC2 instance

1. The VPC Page looks like below
   - ![alt text](imgs/image.png)
1. Create VPC and More
   - ![alt text](imgs/image-1.png)
   - here Public and Private Netword will be there by default for Availability zone (2) - like 1a & 1b
1. Creation time :
   - ![alt text](imgs/image-2.png)
1. Open VPC - NACL to check the inbound rule
   - ![alt text](imgs/image-3.png)
   - Here 100 `--->` is priority no for a rule, where lower the number `===>` Higher the priority :
     - ![alt text](imgs/image-4.png)
   - Which means the top most priority rule will be implemented / used.
1. By default AWS adds **Security Group** to EC2 instance to protect it and won't allow any traffic from outside.
1. So now task is to create an EC2 instance with created VPC and do perform below task:
   1. then assigned the VPC to that EC2 instance
   1. for that VPC already allowed some rule before
   1. Change in **SG[Sec. Group]** - to allow only port 13000
   1. check gitea app accessible or not :
      - ![alt text](imgs/image-5.png)
      - ![alt text](imgs/image-6.png)
      - Now change the rule to deny any traffic on 13000 port and check the app :
      - ![alt text](imgs/image-7.png)
      - ![alt text](imgs/image-8.png)
      - Now change the priority in NACL from `90` `-->` `110` and then check app access : [ prediction : it should be accessible ]
      - ![alt text](imgs/image-9.png)
      - ![alt text](imgs/image-10.png)
   1. So over all idea got for NACL and SG.

> [!WARNING]
>
> While creating VPC - I have not associated any public ip by default option , so later on I have to create Elastic IP for it and Associate with the network - **which is chargeable** .
>
> So once PoC done , do disassociate the Ip from network and then release it .
>
> - ![alt text](imgs/image-t1.png)
> - ![alt text](imgs/db_image.png)
