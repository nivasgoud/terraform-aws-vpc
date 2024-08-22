resource "aws_vpc_peering_connection" "peering_module" {
  count = var.is_Peering ? 1 : 0
  vpc_id   = aws_vpc.vpc_module.id
  peer_vpc_id  = var.acceptor_vpc_id == "" ? data.aws_vpc.default.id  : var.acceptor_vpc_id
  auto_accept   = var.is_Peering && var.acceptor_vpc_id == "" ? true : false
  tags = merge(
    var.common_tags,
    var.vpc_peering_tags,
    {
    Name = "${local.name}"
    }
  )
}

resource "aws_route" "public_route_roboshopvpc" {
  count = var.is_Peering && var.acceptor_vpc_id == "" ? 1 : 0
  route_table_id            = aws_route_table.public_route_module.id
  destination_cidr_block    = data.aws_vpc.default.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_module[0].id
}


resource "aws_route" "private_route_roboshopvpc" {
  count = var.is_Peering && var.acceptor_vpc_id == "" ? 1 : 0
  route_table_id            = aws_route_table.private_route_module.id
  destination_cidr_block    = data.aws_vpc.default.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_module[0].id
}

resource "aws_route" "database_route_roboshopvpc" {
  count = var.is_Peering && var.acceptor_vpc_id == "" ? 1 : 0
  route_table_id            = aws_route_table.database_route_module.id
  destination_cidr_block    = data.aws_vpc.default.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_module[0].id
}

resource "aws_route" "public_route_defaultvpc" {
  count = var.is_Peering && var.acceptor_vpc_id == "" ? 1 : 0
  route_table_id            = data.aws_route_table.default.id
  destination_cidr_block    = aws_vpc.vpc_module.id
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_module[0].id
}
