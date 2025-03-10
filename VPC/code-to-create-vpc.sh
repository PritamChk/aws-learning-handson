aws ec2 create-vpc --cidr-block "4.0.0.0/24" --instance-tenancy "default" --tag-specifications '{"resourceType":"vpc","tags":[{"key":"Name","value":"gitea-vpc-vpc"}]}' 
aws ec2 modify-vpc-attribute --vpc-id "preview-vpc-1234" --enable-dns-hostnames '{"value":true}' 
aws ec2 describe-vpcs --vpc-ids "preview-vpc-1234" 
aws ec2 create-vpc-endpoint --vpc-id "preview-vpc-1234" --service-name "com.amazonaws.ap-south-1.s3" --tag-specifications '{"resourceType":"vpc-endpoint","tags":[{"key":"Name","value":"gitea-vpc-vpce-s3"}]}' 
aws ec2 create-subnet --vpc-id "preview-vpc-1234" --cidr-block "4.0.0.0/28" --availability-zone "ap-south-1a" --tag-specifications '{"resourceType":"subnet","tags":[{"key":"Name","value":"gitea-vpc-subnet-public1-ap-south-1a"}]}' 
aws ec2 create-subnet --vpc-id "preview-vpc-1234" --cidr-block "4.0.0.16/28" --availability-zone "ap-south-1b" --tag-specifications '{"resourceType":"subnet","tags":[{"key":"Name","value":"gitea-vpc-subnet-public2-ap-south-1b"}]}' 
aws ec2 create-subnet --vpc-id "preview-vpc-1234" --cidr-block "4.0.0.128/28" --availability-zone "ap-south-1a" --tag-specifications '{"resourceType":"subnet","tags":[{"key":"Name","value":"gitea-vpc-subnet-private1-ap-south-1a"}]}' 
aws ec2 create-subnet --vpc-id "preview-vpc-1234" --cidr-block "4.0.0.144/28" --availability-zone "ap-south-1b" --tag-specifications '{"resourceType":"subnet","tags":[{"key":"Name","value":"gitea-vpc-subnet-private2-ap-south-1b"}]}' 
aws ec2 create-internet-gateway --tag-specifications '{"resourceType":"internet-gateway","tags":[{"key":"Name","value":"gitea-vpc-igw"}]}' 
aws ec2 attach-internet-gateway --internet-gateway-id "preview-igw-1234" --vpc-id "preview-vpc-1234" 
aws ec2 create-route-table --vpc-id "preview-vpc-1234" --tag-specifications '{"resourceType":"route-table","tags":[{"key":"Name","value":"gitea-vpc-rtb-public"}]}' 
aws ec2 create-route --route-table-id "preview-rtb-public-0" --destination-cidr-block "0.0.0.0/0" --gateway-id "preview-igw-1234" 
aws ec2 associate-route-table --route-table-id "preview-rtb-public-0" --subnet-id "preview-subnet-public-0" 
aws ec2 associate-route-table --route-table-id "preview-rtb-public-0" --subnet-id "preview-subnet-public-1" 
aws ec2 create-route-table --vpc-id "preview-vpc-1234" --tag-specifications '{"resourceType":"route-table","tags":[{"key":"Name","value":"gitea-vpc-rtb-private1-ap-south-1a"}]}' 
aws ec2 associate-route-table --route-table-id "preview-rtb-private-1" --subnet-id "preview-subnet-private-2" 
aws ec2 create-route-table --vpc-id "preview-vpc-1234" --tag-specifications '{"resourceType":"route-table","tags":[{"key":"Name","value":"gitea-vpc-rtb-private2-ap-south-1b"}]}' 
aws ec2 associate-route-table --route-table-id "preview-rtb-private-2" --subnet-id "preview-subnet-private-3" 
aws ec2 describe-route-tables --route-table-ids   "preview-rtb-private-1" "preview-rtb-private-2" 
aws ec2 modify-vpc-endpoint --vpc-endpoint-id "preview-vpce-1234" --add-route-table-ids "preview-rtb-private-1" "preview-rtb-private-2" 