terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# VPC
resource "aws_vpc" "jco_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.prefix}-vpc-${var.vpc_identifier}"
  }
}

# Subnet
resource "aws_subnet" "jco_subnet" {
  vpc_id                  = aws_vpc.jco_vpc.id
  cidr_block              = var.subnet_cidr_block
  map_public_ip_on_launch = true
  availability_zone       = "${var.region}${var.availability_zone}"

  tags = {
    Name = "${var.prefix}-public-subnet-${var.subnet_identifier}"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "jco_igw" {
  vpc_id = aws_vpc.jco_vpc.id

  tags = {
    Name = "${var.prefix}-ig-${var.vpc_identifier}"
  }
}

# Route table
resource "aws_route_table" "jco_rt_table" {
  vpc_id = aws_vpc.jco_vpc.id

  tags = {
    Name = "${var.prefix}-rt-${var.vpc_identifier}"
  }
}

# Route
resource "aws_route" "jco_rt" {
  route_table_id         = aws_route_table.jco_rt_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.jco_igw.id

}

# Route Table Association 
resource "aws_route_table_association" "jco_rt_association" {
  subnet_id      = aws_subnet.jco_subnet.id
  route_table_id = aws_route_table.jco_rt_table.id
}

# Security Group
resource "aws_security_group" "jco_sg" {
  vpc_id = aws_vpc.jco_vpc.id
  ingress {
    cidr_blocks = ["${var.ingress_cidr_blocks}"]
    from_port   = var.ingress_port
    to_port     = var.ingress_port
    protocol    = var.ingress_protocol
  }
  egress {
    cidr_blocks = ["${var.egress_cidr_blocks}"]
    from_port   = var.egress_port
    to_port     = var.egress_port
    protocol    = var.egress_protocol
  }

  tags = {
    Name = "${var.prefix}-sg-${var.subnet_identifier}"
  }
}

# SSH Key
resource "aws_key_pair" "jco_key" {
  key_name   = "${var.prefix}-key-${var.ec2_identifier}"
  public_key = var.ssh_public_key
}

# EC2
resource "aws_instance" "jco_ec2" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.jco_subnet.id
  user_data     = var.user_data
  key_name      = aws_key_pair.jco_key.key_name
  vpc_security_group_ids = [ aws_security_group.jco_sg.id ]
  iam_instance_profile = var.instance_role
  
  tags = {
    Name = "${var.prefix}-ec2-${var.ec2_identifier}"
  }

}

