# Instance Type
variable "instance_type" {
  type        = string
  default     = "t2.micro"
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

# Ingress CIDR Blocks
variable "ingress_cidr_blocks" {
  type        = string
  description = "Ingress CIDR blocks for SG"
}

# Egress CIDR Blocks
variable "egress_cidr_blocks" {
  type        = string
  description = "Egress CIDR blocks for SG"
}
