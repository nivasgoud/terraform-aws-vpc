output "aws_availability_zones" {
  value = data.aws_availability_zones.available.names
}

output "slicing_zones" {
  value = slice(data.aws_availability_zones.available.names,0,2)
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet_module[*].id
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet_module[*].id
}

output "database_subnet_id" {
  value = aws_subnet.database_subnet_module[*].id
}

output "default_id" {
  value = data.aws_vpc.default.id
}

output "default_cidrblock" {
  value = data.aws_vpc.default.cidr_block
}

output "default_routetable" {
  value = data.aws_route_table.default.id
}