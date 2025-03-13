# install AWS CLI

---

> here I have installed on Windows system
>
> Donwload Link and DOC:
>
> [https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
>
> or
>
> ```ps
> msiexec.exe /i https://awscli.amazonaws.com/AWSCLIV2.msi
> ```

> [!NOTE]
>
> add the installed exe file path in environment variable
>
> - ![alt text](imgs/image.png)

---

# Connect to AWS account through CLI

> [!DANGER]
> Ideally I should access IAM user , but now I'll go ahead with root user -->

1. login to root/iam user
   - ![alt text](imgs/image-1.png)
1. Then Create the Access Key
   - ![alt text](imgs/image-2.png)
1. Configure in aws cli
   - ![alt text](imgs/image-3.png)
   - ![alt text](imgs/image-4.png)

# Example: Post connection :

1. `aws iam list-users`

   - ![alt text](imgs/image-5.png)

1. Create EC2 Instance
   - CreateSecurityGroup
     ```sh
     aws ec2 create-security-group --group-name "launch-wizard-1" \
     --description "launch-wizard-1 created" \
     ```
     - ![alt text](imgs/image-6.png)
   - AuthorizeSecurityGroupIngress
     ```sh
     aws ec2 authorize-security-group-ingress --group-id "sg-0f04a3a3ffcb0ff4f" --ip-permissions '{"IpProtocol":"tcp","FromPort":22,"ToPort":22,"IpRanges":[{"CidrIp":"0.0.0.0/0"}]}' '{"IpProtocol":"tcp","FromPort":80,"ToPort":80,"IpRanges":[{"CidrIp":"0.0.0.0/0"}]}'
     ```
     - ![alt text](imgs/image-7.png)
   - RunInstances
     ```sh
     aws ec2 run-instances --imgs/image-id 'ami-05c179eced2eb9b5b' --instance-type "t2.micro" --key-name "aws_1st_ec2_vm" --network-interfaces '{"AssociatePublicIpAddress":true,"DeviceIndex":0,"Groups":["sg-0f04a3a3ffcb0ff4f"]}' --credit-specification '{"CpuCredits":"standard"}' --tag-specifications '{"ResourceType":"instance","Tags":[{"Key":"Name","Value":"vm1-example-prod"}]}' --metadata-options '{"HttpEndpoint":"enabled","HttpPutResponseHopLimit":2,"HttpTokens":"required"}' --private-dns-name-options '{"HostnameType":"ip-name","EnableResourceNameDnsARecord":true,"EnableResourceNameDnsAAAARecord":false}'  --count "1"
     ```

# trying to start the classroom backend

![alt text](imgs/image-8.png)
