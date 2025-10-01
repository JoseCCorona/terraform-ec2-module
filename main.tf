# VPC
resource "aws_vpc" "jco_vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.prefix}-vpc"
  }
}

# Subnet
resource "aws_subnet" "jco_subnet" {
  vpc_id                  = aws_vpc.jco_vpc.id
  cidr_block              = "10.123.0.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${var.region}${var.availability_zone}"

  tags = {
    Name = "${var.prefix}-public-subnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "jco_igw" {
  vpc_id = aws_vpc.jco_vpc.id

  tags = {
    Name = "${var.prefix}-ig"
  }
}

# Route table
resource "aws_route_table" "jco_rt_table" {
  vpc_id = aws_vpc.jco_vpc.id

  tags = {
    Name = "${var.prefix}-rt"
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
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
  egress {
    cidr_blocks = ["${var.egress_cidr_blocks}"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }

  tags = {
    Name = "${var.prefix}-sg"
  }
}

# SSH Key
resource "aws_key_pair" "jco_key" {
  key_name   = "${var.prefix}-key"
  public_key = file("~/.ssh/${var.prefix}-key.pub")
}

# EC2
resource "aws_instance" "jco_ec2" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.jco_subnet.id
  user_data     = file("sys-update.sh")
  key_name      = aws_key_pair.jco_key.key_name
  vpc_security_group_ids = [ aws_security_group.jco_sg.id ]
  
  tags = {
    Name = "${var.prefix}-ec2"
  }
}