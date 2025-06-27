resource "aws_ecs_task_definition" "this" {
  family                   = var.name
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_execution.arn

  container_definitions = jsonencode([
    {
      name      = var.name
      image     = var.container_image
      essential = true
      portMappings = [
        {
          containerPort = 3000
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-group         = "/ecs/devops-demo",
          awslogs-region        = var.region,
          awslogs-stream-prefix = var.name
        }
      }
    }
  ])
}

resource "aws_ecs_service" "this" {
  name            = "${var.name}-svc"
  cluster         = var.cluster
  launch_type     = "FARGATE"
  desired_count   = 1

  task_definition = aws_ecs_task_definition.this.arn

  network_configuration {
    subnets         = var.subnet_ids
    security_groups = [var.sg_id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.tg_arn
    container_name   = var.name
    container_port   = 3000
  }

  depends_on = [aws_ecs_task_definition.this]
}

resource "aws_iam_role" "ecs_execution" {
  name = "${var.name}-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_execution_policy" {
  role       = aws_iam_role.ecs_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

