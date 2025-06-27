variable "project_name" {}
variable "container_image_appointment" {}
variable "container_image_patient" {}
variable "aws_region" {}
variable "vpc_id" {}
variable "alb_sg_id" {}
variable "app_sg_id" {}
variable "public_subnet_ids" {
  type = list(string)
}
variable "private_subnet_ids" {
  type = list(string)
}

