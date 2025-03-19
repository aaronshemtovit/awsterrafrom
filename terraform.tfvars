vpc_cidr_block         = "10.0.0.0/16"

public_subnet_1_cidr   = "10.0.1.0/24"
public_subnet_2_cidr   = "10.0.2.0/24"
public_subnet_3_cidr   = "10.0.3.0/24"

private_subnet_1_cidr  = "10.0.11.0/24"
private_subnet_2_cidr  = "10.0.12.0/24"
private_subnet_3_cidr  = "10.0.13.0/24"

availability_zones     = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]

ec2_ami                = "ami-02c8957853f7c1073"
ec2_instance_type      = "t3.small"
ec2_key_name           = "awsinternshipuser"