locals {
  name = "${var.ProjectName}-${var.Environment}"
  azs = slice(data.aws_availability_zones.available.names,0,2)
}