output "available_zones_roboshop" {
  value = module.vpc_infra.aws_availability_zones
    }

output "slicing_zones_test" {
  value = module.vpc_infra.slicing_zones
}

output "subnet_id_test" {
  value = module.vpc_infra.database_subnet_id
}

output "default_vpc_details" {
  value = module.vpc_infra.default_id
}

output "default_routetable" {
  value = module.vpc_infra.default_routetable
}