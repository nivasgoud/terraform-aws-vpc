variable "cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "common_tags" {
  type = map
  default = {
    Project = "roboshop"
    Environment = "dev"
    Terraform = "true"
  }
}
variable "tagssss" {
  type = map
  default = {}
}


variable "igw_tagssss" {
  type = map
  default = {}
  }

variable "Project_Name" {
  type = string
  default = "roboshop"
}

variable "Environment" {
  type = string
  default = "dev"
}

variable "public_subnet_cidr_test" {
  type = list
  default = ["10.0.1.0/24","10.0.2.0/24"]
}

variable "private_subnet_cidr_test" {
  type = list
  default = ["10.0.3.0/24","10.0.4.0/24"]
}

variable "database_subnet_cidr_test" {
 type = list
 default = ["10.0.5.0/24" , "10.0.6.0/24"]
}