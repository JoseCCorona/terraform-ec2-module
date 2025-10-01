output "jco_vpc" {
  value = aws_vpc.jco_vpc.id
}

output "jco_subnet" {
  value = aws_subnet.jco_subnet.id
}

output "jco_igw" {
  value = aws_internet_gateway.jco_igw.id
}

output "jco_rt" {
  value = aws_route_table.jco_rt_table.id
}

output "jco_rt_table" {
  value = aws_route.jco_rt.id
}

output "jco_rt_association" {
  value = aws_route_table_association.jco_rt_association.id
}

output "jco_sg" {
  value = aws_security_group.jco_sg.id
}

output "jco_key" {
  value = aws_key_pair.jco_key.id
}

output "jco_ec2_id" {
  value = aws_instance.jco_ec2.id
}

output "jco_ec2_name" {
  value = aws_instance.jco_ec2.tags.Name
}

output "jco_ec2_public_ip" {
  value = aws_instance.jco_ec2.public_ip
}

