resource "aws_vpc" "vpc_module" {
  cidr_block       = var.cidr
  enable_dns_hostnames  = true
  tags = merge(var.vpc_tags,var.common_tags,
  {
    Name = local.name
  })
}

resource "aws_internet_gateway" "gw_module" {
  vpc_id = aws_vpc.vpc_module.id

  tags = merge(var.igw_tags,var.common_tags,
  {
    Name = local.name
  })
}

resource "aws_subnet" "public_subnet_module" {
  count = length(var.public_subnet_cidr)
  vpc_id     = aws_vpc.vpc_module.id
  map_public_ip_on_launch = true
  cidr_block = var.public_subnet_cidr[count.index]
  availability_zone =local.azs[count.index]
  tags = merge(
    var.public_subnet_tags,var.common_tags,
  {
    Name = "${local.name}-public-${local.azs[count.index]}"
  }
  )
}

resource "aws_subnet" "private_subnet_module" {
  count = length(var.private_subnet_cidr)
  vpc_id     = aws_vpc.vpc_module.id
  #map_public_ip_on_launch = true
  cidr_block = var.private_subnet_cidr[count.index]
  availability_zone =local.azs[count.index]
  tags = merge(
    var.private_subnet_tags,var.common_tags,
  {
    Name = "${local.name}-private-${local.azs[count.index]}"
  }
  )
}

resource "aws_subnet" "database_subnet_module" {
  count = length(var.database_subnet_cidr)
  vpc_id     = aws_vpc.vpc_module.id
  #map_public_ip_on_launch = true
  cidr_block = var.database_subnet_cidr[count.index]
  availability_zone =local.azs[count.index]
  tags = merge(
    var.database_subnet_tags,var.common_tags,
  {
    Name = "${local.name}-database-${local.azs[count.index]}"
  }
  )
}

resource "aws_eip" "elasticip_module" {
  domain   = "vpc"
}

resource "aws_nat_gateway" "Ngw_module" {
  allocation_id = aws_eip.elasticip_module.id
  subnet_id     = aws_subnet.public_subnet_module[0].id

  tags = merge(
    var.common_tags,var.aws_nat_gateway_tags,
    {
      Name = local.name
    }
  )

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw_module]
}



resource "aws_route_table" "public_route_module" {
  vpc_id = aws_vpc.vpc_module.id

  tags = merge(
    var.common_tags,var.public_route_tags,
  {
    Name = "${local.name}-public"

  }
  )
}

resource "aws_route_table" "private_route_module" {
  vpc_id = aws_vpc.vpc_module.id

  tags = merge(
    var.common_tags,var.private_route_tags,
  {
    Name = "${local.name}-private"

  }
  )
}

resource "aws_route_table" "database_route_module" {
  vpc_id = aws_vpc.vpc_module.id

  tags = merge(
    var.common_tags,var.database_route_tags,
  {
    Name = "${local.name}-database"

  }
  )
}

resource "aws_route" "public_routinsert_module" {
  route_table_id            = aws_route_table.public_route_module.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.gw_module.id
}

resource "aws_route" "private_routinsert_module" {
  route_table_id            = aws_route_table.private_route_module.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_nat_gateway.Ngw_module.id
}

resource "aws_route" "database_routinsert_module" {
  route_table_id            = aws_route_table.database_route_module.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_nat_gateway.Ngw_module.id
}

# resource "aws_route_table_association" "public_association_module" {
#   count = length(aws_subnet.public_subnet_module)
#   subnet_id      = aws_subnet.public_subnet_module[count.index].id
#   route_table_id = aws_route_table.public_route_module.id
# }

resource "aws_route_table_association" "public_association_module" {
  count = length(var.public_subnet_cidr)
  subnet_id      = element(aws_subnet.public_subnet_module[*].id, count.index)
  route_table_id = aws_route_table.public_route_module.id
}

resource "aws_route_table_association" "private_association_module" {
  count = length(var.private_subnet_cidr)
  subnet_id      = element(aws_subnet.private_subnet_module[*].id, count.index)
  route_table_id = aws_route_table.private_route_module.id
}

resource "aws_route_table_association" "database_association_module" {
  count = length(var.database_subnet_cidr)
  subnet_id      = element(aws_subnet.database_subnet_module[*].id, count.index)
  route_table_id = aws_route_table.database_route_module.id
}
