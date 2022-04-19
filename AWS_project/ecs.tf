resource "aws_ecs_cluster" "ghost_cluster" {
  name = "ghost"
}
resource "aws_ecr_repository" "ghost_ecr_repository" {
  name = "ghost_ecr_repository"
}
resource "aws_ecs_task_definition" "ghost" {
  family                   = "ghost"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ghost_role.arn
  cpu                      = 256
  memory                   = 1024
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "ghost_ecr_repository",
    "image": "041007482309.dkr.ecr.us-east-1.amazonaws.com/ghost_ecr_repository:latest",
    "cpu": 256, 
    "memory": 1024,
    "essential": true,
    "portMappings": [
      {
        "containerPort": 2368,
        "hostPort": 2368
      }
    ]
  }
]
TASK_DEFINITION
  volume {
    name = "ghost_storage"
    efs_volume_configuration {
      file_system_id = aws_efs_file_system.foo_with_lifecyle_policy.id
      root_directory = "/var/lib/ghost/content"
      transit_encryption = "ENABLED"
    }
  }
}
resource "aws_ecs_service" "attached" {
  name            = "attached"
  cluster         = aws_ecs_cluster.ghost_cluster.id
  task_definition = aws_ecs_task_definition.ghost.arn
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = [aws_subnet.private_a.id, aws_subnet.private_b.id, aws_subnet.private_c.id]
    assign_public_ip = false
    security_groups  = [aws_security_group.fargate_pool.id]
  }
  desired_count = 3
  load_balancer {
    target_group_arn = aws_lb_target_group.ghost-fargate.arn
    container_name   = "ghost_ecr_repository"
    container_port   = 2368
  }
}

/*
#========================
resource "aws_ecs_cluster" "ghost_cluster" {
  name = "ghost"
}
resource "aws_ecr_repository" "ghost_ecr_repository" {
  name = "ghost_ecr_repository"
}
resource "aws_ecs_task_definition" "ghost" {
  family                   = "ghost"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ghost_app_role.arn
  cpu                      = 256
  memory                   = 1024
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "ghost_ecr_repository",
    "image": "498614279603.dkr.ecr.us-east-1.amazonaws.com/ghost_ecr_repository:latest",
    "cpu": 256,
    "memory": 1024,
    "essential": true,
    "portMappings": [
      {
        "containerPort": 2368,
        "hostPort": 2368
      }
    ]
  }
]
TASK_DEFINITION
  volume {
    name = "ghost_storage"
    efs_volume_configuration {
      file_system_id = aws_efs_file_system.foo_with_lifecyle_policy.id
      root_directory = "/var/lib/ghost/content"
    }
  }
}
resource "aws_ecs_service" "attached" {
  name            = "attached"
  cluster         = aws_ecs_cluster.ghost_cluster.id
  task_definition = aws_ecs_task_definition.ghost.arn
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = [aws_subnet.private_a.id, aws_subnet.private_b.id, aws_subnet.private_c.id]
    assign_public_ip = false
# security_groups  = aws_security_group.fargate_pool.id
  }
  desired_count = 3
  load_balancer {
    target_group_arn = aws_lb_target_group.ghost-fargate.arn
    container_name   = "ghost_ecr_repository"
    container_port   = 2368
  }
}
#================

resource "aws_ecs_cluster" "ghost_cluster" {
  name = "ghost"
}

resource "aws_ecs_task_definition" "ghost"{
    family                      = "ghost-task"
    execution_role_arn          = aws_iam_role.ghost_app_role.arn
    network_mode                = "awsvpc"
    requires_compatibilities   = ["FARGATE"]
    cpu                         = 256
    memory                      = 1024
    container_definitions      = <<TASK_DEFINITION
[
  {
    "name": "ghost_ecr_repository",
    "image": "098410899641.dkr.ecr.us-east-1.amazonaws.com/ghost_ecr_repository:latest",
    "cpu": 256, 
    "memory": 1024,
    "essential": true
  }
]
TASK_DEFINITION
}
resource "aws_ecs_service" "ghost" {
    name            = "ghost-service-attached"
    cluster         = aws_ecs_cluster.ghost_cluster.id
    task_definition = aws_ecs_task_definition.ghost.arn
    launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.private_a.id, aws_subnet.private_b.id, aws_subnet.private_c.id]
    assign_public_ip = false
    security_groups  = [aws_security_group.fargate_pool.id]
  }

   load_balancer {
    target_group_arn = aws_lb_target_group.ghost-fargate.arn
    container_name   = "ghost_ecr_repository"
    container_port   = 2368
  }
}




/*

resource "aws_ecs_cluster" "ghost_cluster" {
  name = "ghost"
}
resource "aws_ecr_repository" "ghost_ecr_repository" {
  name = "ghost_ecr_repository"
}
resource "aws_ecs_task_definition" "ghost" {
  family                   = "ghost"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ghost_app_role.arn
  cpu                      = 256
  memory                   = 1024
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "ghost_ecr_repository",
    "image": "217859617624.dkr.ecr.us-east-1.amazonaws.com/ghost_ecr_repository:latest",
    "cpu": 256,
    "memory": 1024,
    "essential": true,
    "portMappings": [
      {
        "containerPort": 2368,
        "hostPort": 2368
      }
    ]
  }
]
TASK_DEFINITION
  volume {
    name = "ghost_storage"
    efs_volume_configuration {
      file_system_id = aws_efs_file_system.foo_with_lifecyle_policy.id
      root_directory = "/var/lib/ghost/content"
    }
  }
}
resource "aws_ecs_service" "attached" {
  name            = "attached"
  cluster         = aws_ecs_cluster.ghost_cluster.id
  task_definition = aws_ecs_task_definition.ghost.arn
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = [aws_subnet.private_a.id, aws_subnet.private_b.id, aws_subnet.private_c.id]
    assign_public_ip = false
    security_groups  = aws_security_group.fargate_pool.id
  }
  desired_count = 3
  load_balancer {
    target_group_arn = aws_lb_target_group.ghost-fargate.arn
    container_name   = "ghost_ecr_repository"
    container_port   = 2368
  }
}

*/