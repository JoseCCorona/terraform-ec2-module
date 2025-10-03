# VPC CIDR Block
variable "vpc_cidr_block"{
  type        = string
  default = "10.123.0.0/16"
  description = "CIDR blocks for VPC"
} 

# VPC Name Identifier
variable "vpc_identifier"{
  type        = string
  default = "01"
  description = "Identifier for VPC name"
} 

# Subnet CIDR Block
variable "subnet_cidr_block"{
  type        = string
  default = "10.123.0.0/24"
  description = "CIDR blocks for subnet"
}

# Subnet Name Identifier
variable "subnet_identifier"{
  type        = string
  default = "01"
  description = "Identifier for subnet name"
} 

# Ingress CIDR Blocks
variable "ingress_cidr_blocks" {
  type        = string
  description = "Ingress CIDR blocks for SG"
}

# SG Ingress port
variable "ingress_port"{
  type        = number
  default = "80"
  description = "Ingress port for SG"
} 

# SG Ingress protocol
variable "ingress_protocol"{
  type        = string
  default = "tcp"
  description = "Ingress protocol for SG"
} 

# Egress CIDR Blocks
variable "egress_cidr_blocks" {
  type        = string
  default = "0.0.0.0/0"
  description = "Egress CIDR blocks for SG"
}

# SG Egress port
variable "egress_port"{
  type        = number
  default = "0"
  description = "Egress port for SG"
} 

# SG Egress protocol
variable "egress_protocol"{
  type        = string
  default = "-1"
  description = "Egress protocol for SG"
} 

# Instance Type
variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "Defines the type of EC2 to be deploy"
}

# AMI
variable "ami" {
  type        = string
  default     = "ami-00ca32bbc84273381"
  description = "AMI to be used on ec2 deployment"
}

# Region
variable "region" {
  type        = string
  default     = "us-east-1"
  description = "Geographical region of resource deployment"
}

# Availability Zone
variable "availability_zone" {
  type        = string
  default     = "a"
  description = "Avalability zone of resource deployment"
}

# Prefix
variable "prefix" {
  type        = string
  default     = "jco"
  description = "Prefix for resource naming convention"
}

# SSH Public Key
variable "ssh_public_key" {
  type        = string
  description = "SSH Public Key"
}

# User Data
variable "user_data" {
  type        = string
  default     = "jco"
  description = "User Data for provisioned EC2"
}

# EC2 Name Identifier
variable "ec2_identifier"{
  type        = string
  default = "01"
  description = "Identifier for EC2 name"
} 



