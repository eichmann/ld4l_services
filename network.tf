variable "vpc_id" {
  type = string
}

variable "default_sg" {
  type = list
}

variable "sg_efs_for_ecs" {
  type = list
}

data "aws_vpc" "selected_vpc" {
  id = var.vpc_id
}

data "aws_subnet_ids" "public_subnets" {
  vpc_id = data.aws_vpc.selected_vpc.id

  tags = {
    Name = "cu-lit-Subnet-Public-*"
  }
}

data "aws_subnet_ids" "private_subnets" {
  vpc_id = data.aws_vpc.selected_vpc.id

  tags = {
    Name = "cu-lit-Subnet-Private-*"
  }
}
