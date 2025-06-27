variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "devops-demo"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of public subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "List of private subnet CIDRs"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "azs" {
  description = "Availability Zones"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b"]
}

variable "container_image_patient" {
  description = "ECR image URI for Patient service"
  type        = string
  default     = "373649774472.dkr.ecr.ap-south-1.amazonaws.com/patient-service:latest"
}

variable "container_image_appointment" {
  description = "ECR image URI for Appointment service"
  type        = string
  default     = "373649774472.dkr.ecr.ap-south-1.amazonaws.com/appointment-service:latest"
}

