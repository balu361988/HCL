project_name               = "devops-demo"
aws_region                 = "ap-south-1"
vpc_cidr                   = "10.0.0.0/16"
public_subnet_cidrs        = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs       = ["10.0.101.0/24", "10.0.102.0/24"]
azs                        = ["ap-south-1a", "ap-south-1b"]

container_image_appointment = "373649774472.dkr.ecr.ap-south-1.amazonaws.com/appointment-service:latest"
container_image_patient     = "373649774472.dkr.ecr.ap-south-1.amazonaws.com/patient-service:latest"

