variable "cidr" {
  type = string
  default = ""
}

variable "common_tags" {
  type = map
  default = {}
}

variable "vpc_tags" {
  type = map
  default = {}
}

variable "igw_tags" {
  type = map
  default = {}
}

variable "ProjectName" {
  type = string
}

variable "Environment" {
  type = string
}

variable "public_subnet_tags" {
    type = map
    default = {} 
}

variable "public_subnet_cidr" {
    type = list
    validation {
      condition = length(var.public_subnet_cidr) == 2
      error_message = "Please give 2 public valid subnet CIDR"
    }  
}

variable "private_subnet_tags" {
  type = map
  default = {}
}

variable "private_subnet_cidr" {
  type = list
  validation {
    condition = length(var.private_subnet_cidr) == 2
    error_message = "Please give 2 private valid subnet CIDR"
  }
}

variable "database_subnet_tags" {
  type = map
  default = {}
}

variable "database_subnet_cidr" {
  type = list
  validation {
    condition = length(var.database_subnet_cidr) == 2
    error_message = "Please give 2 private valid subnet CIDR"
  }
}

variable "aws_nat_gateway_tags" {
  type = map
  default = {}
  
}

variable "public_route_tags" {
  type = map
  default = {}
  
}

variable "private_route_tags" {
  type = map
  default = {}
  
}

variable "database_route_tags" {
  type = map
  default = {}
  
}

variable "is_Peering" {
  type = bool
  default = false
}

variable "acceptor_vpc_id" {
  type = string
  default = ""
}

variable "vpc_peering_tags" {
  type = map
  default = {}
}