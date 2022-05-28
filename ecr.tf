variable "ecr_repository" {
  type = string
}

variable "ecr_image_tag" {
  type = string
}

data "aws_ecr_repository" "repository" {
  name = var.ecr_repository
}

data "aws_ecr_image" "service_image" {
  repository_name = var.ecr_repository
  image_tag       = var.ecr_image_tag
}