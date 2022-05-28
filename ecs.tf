data "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"
}

resource "aws_ecs_cluster" "cluster" {
  name = "ld4l_services"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Application          = "LD4P"
    "Cost Center"        = "L858313"
    "Functional Contact" = "elr37"
    "Technical Contact"  = "gad22"
  }
}

resource "aws_ecs_task_definition" "task_definition" {
  container_definitions    = jsonencode([
    {
      cpu : 0,
      environment : [],
      essential : true,
      image : "${data.aws_ecr_repository.repository.repository_url}:latest"

      logConfiguration : {
        "logDriver" : "awslogs",
        "options" : {
          "awslogs-group" : var.ecs_log_group,
          "awslogs-region" : var.aws_logging_region,
          "awslogs-stream-prefix" : "ecs"
        }
      },
      mountPoints : [
        {
          "containerPath" : "lucene",
          "sourceVolume" : "lucene"
        }
      ],
      name : "ld4l_services",
      portMappings : [
        {
          "containerPort" : 80,
          "hostPort" : 80,
          "protocol" : "tcp"
        },
        {
          "containerPort" : 8080,
          "hostPort" : 8080,
          "protocol" : "tcp"
        },
        {
          "containerPort" : 443,
          "hostPort" : 443,
          "protocol" : "tcp"
        }
      ],
      volumesFrom : []
    }
  ])
  cpu                      = "256"
  execution_role_arn       = data.aws_iam_role.ecs_task_execution_role.arn
  family                   = "ld4l_services"
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  runtime_platform {
    operating_system_family = "LINUX"
  }

  tags = {
    "Application"        = "LD4P"
    "Cost Center"        = "L858313"
    "Functional Contact" = "elr37"
    "Technical Contact"  = "gad22"
  }

  task_role_arn = data.aws_iam_role.ecs_task_execution_role.arn

  volume {
    efs_volume_configuration {
      authorization_config {
        access_point_id = aws_efs_access_point.ld4l_services_efs_data_ap.id
        iam             = "DISABLED"
      }

      file_system_id     = aws_efs_file_system.ld4l_services_efs.id
      root_directory     = "/"
      transit_encryption = "ENABLED"
    }

    name = "lucene"
  }

}

resource "aws_ecs_service" "ld4l_services_service" {
  cluster = aws_ecs_cluster.cluster.id

  deployment_circuit_breaker {
    enable   = "true"
    rollback = "true"
  }

  deployment_controller {
    type = "ECS"
  }

  deployment_maximum_percent         = "200"
  deployment_minimum_healthy_percent = "100"
  desired_count                      = "2"
  enable_ecs_managed_tags            = "true"
  enable_execute_command             = "true"
  health_check_grace_period_seconds  = "600"
  launch_type                        = "FARGATE"

#  load_balancer {
#    container_name   = "ld4l_services"
#    container_port   = "443"
#    target_group_arn = aws_lb_target_group.tg_ip_443.arn
#  }

  load_balancer {
    container_name   = "ld4l_services"
    container_port   = "8080"
    target_group_arn = aws_lb_target_group.tg_ip_8080.arn
  }

  name = "ld4l_services_service"

  network_configuration {
    assign_public_ip = "false"
    security_groups  = var.default_sg
    subnets          = toset(data.aws_subnet_ids.private_subnets.ids)
  }

  platform_version    = "LATEST"
  propagate_tags      = "SERVICE"
  scheduling_strategy = "REPLICA"
  task_definition     = aws_ecs_task_definition.task_definition.id
}


