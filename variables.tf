variable "vpc_cidr_block" {
  description = "CIDR block for the main VPC"
  type        = string
}

variable "public_subnet_1_cidr" {
  description = "CIDR block for public subnet 1"
  type        = string
}

variable "public_subnet_2_cidr" {
  description = "CIDR block for public subnet 2"
  type        = string
}

variable "public_subnet_3_cidr" {
  description = "CIDR block for public subnet 3"
  type        = string
}

variable "private_subnet_1_cidr" {
  description = "CIDR block for private subnet 1"
  type        = string
}

variable "private_subnet_2_cidr" {
  description = "CIDR block for private subnet 2"
  type        = string
}

variable "private_subnet_3_cidr" {
  description = "CIDR block for private subnet 3"
  type        = string
}

variable "availability_zones" {
  description = "Availability zones for subnets"
  type        = list(string)
}

variable "ec2_ami" {
  description = "AMI ID for EC2 instance"
  type        = string
}

variable "ec2_instance_type" {
  description = "Instance type for EC2"
  type        = string
}

variable "ec2_key_name" {
  description = "Key pair name for EC2 instance"
  type        = string
}

variable "nat_eip_allocation_id" {
  description = "Allocation ID of EIP for NAT Gateway"
  type        = string
}
