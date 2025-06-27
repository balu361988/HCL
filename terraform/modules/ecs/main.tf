resource "aws_ecs_cluster" "this" {
  name = "${var.project_name}-ecs-cluster"
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "/ecs/${var.project_name}"
  retention_in_days = 7
}

resource "aws_lb" "this" {
  name               = "${var.project_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = var.public_subnet_ids
}

resource "aws_lb_target_group" "appointment" {
  name        = "${var.project_name}-appointment-tg"
  port        = 3000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    path                = "/"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group" "patient" {
  name        = "${var.project_name}-patient-tg"
  port        = 3000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    path                = "/"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Not Found"
      status_code  = "404"
    }
  }
}

resource "aws_lb_listener_rule" "appointment" {
  listener_arn = aws_lb_listener.this.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.appointment.arn
  }

  condition {
    path_pattern {
      values = ["/appointment"]
    }
  }
}

resource "aws_lb_listener_rule" "patient" {
  listener_arn = aws_lb_listener.this.arn
  priority     = 200

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.patient.arn
  }

  condition {
    path_pattern {
      values = ["/patient"]
    }
  }
}

module "appointment_service" {
  source           = "./service"
  name             = "appointment"
  container_image  = var.container_image_appointment
  region           = var.aws_region
  cluster          = aws_ecs_cluster.this.id
  tg_arn           = aws_lb_target_group.appointment.arn
  subnet_ids       = var.private_subnet_ids
  sg_id            = var.app_sg_id
  log_group        = aws_cloudwatch_log_group.this.name
}

module "patient_service" {
  source           = "./service"
  name             = "patient"
  container_image  = var.container_image_patient
  region           = var.aws_region
  cluster          = aws_ecs_cluster.this.id
  tg_arn           = aws_lb_target_group.patient.arn
  subnet_ids       = var.private_subnet_ids
  sg_id            = var.app_sg_id
  log_group        = aws_cloudwatch_log_group.this.name
}

