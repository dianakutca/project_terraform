# Terraform project on AWS
![Ansible](/images/terraform.png)

___

 ### Prerequisites
 For this guide, you will need:

- AWS account
- EC2 instance with terraform installed on it (version Terraform v1.1.1)

### Set up and initialize your Terraform workspace
In your terminal, clone the following repository. Once you have cloned the repository, initialize your Terraform workspace, which will download and configure the providers.
You will have to create variable file, with all variables and name it "virginia.tfvars" or any other region you need
The variable file should content :
```
region              = " "
```
path_to_public_key  = " "
```
path_to_private_key = " "
instance_username   = "ec2-user" #or any other user which will connect to remote terminal
cidr_block          = " " #for VPC
sec_group_name      = " "
public_subnet1      = " " #cidr block for public subnet1
public_subnet2      = " " #cidr block for public subnet2
public_subnet3      = " " #cidr block for public subnet3
private_subnet1     = " " #cidr block for private subnet1
private_subnet2     = " " #cidr block for private subnet2
private_subnet3     = " " #cidr block for private subnet3
availability_zone   = " " #where will main instance be created. It will be connected to DS cluster 
availability_zones = [
 " ",
  " ",
  " "
 ]

 database_name      = " "
 cluster_identifier = " "
master_username    = " "
master_password    = " "

tags = { #Optional
  Dept = " "
  Team = " "
}


domain = " " #name of your domain for creating record using Route53
zone_id = " " #zone id for your domain 

Depends on the region you choose before please run the followin commands :

terraform init && terraform apply -var-file regions/name-of-your-folder.tfvars   -auto-approve

or 

see the Makefile for shortcuts examples
