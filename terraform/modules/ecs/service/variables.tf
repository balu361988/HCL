variable "name" {}
variable "container_image" {}  # ✅ Correct name
variable "cluster" {}
variable "tg_arn" {}
variable "subnet_ids" {
  type = list(string)
}
variable "sg_id" {}
variable "log_group" {}
variable "region" {}

