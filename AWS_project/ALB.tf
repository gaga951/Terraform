resource "aws_lb" "ghost_lb" {
  name               = "ghost-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = [aws_subnet.public_a.id, aws_subnet.public_b.id, aws_subnet.public_c.id]
  tags = {
    Environment = "production"
  }
}
resource "aws_lb_target_group" "ghost-ec2" {
  name     = "ghost-ec2"
  port     = 2368
  protocol = "HTTP"
  vpc_id   = aws_vpc.cloudx.id
}
resource "aws_lb_target_group" "ghost-fargate" {
  name     = "ghost-fargate"
  port     = 2368
  protocol = "HTTP"
  target_type = "ip"
  vpc_id   = aws_vpc.cloudx.id
}
resource "aws_lb_listener" "ghost_listener_ec2" {
  load_balancer_arn = aws_lb.ghost_lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
resource "aws_lb_listener_rule" "host_based_routing" {
  listener_arn = aws_lb_listener.ghost_listener_ec2.arn
  priority     = 99
  action {
    type = "forward"
    forward {
      target_group {
        arn    = aws_lb_target_group.ghost-ec2.arn
        weight = 70
      }
      target_group {
        arn    = aws_lb_target_group.ghost-fargate.arn
        weight = 30
      }
    }
  }
  condition {
    path_pattern {
      values = ["/static/*"]
    }
  }
/*
  lifecycle {
    create_before_destroy = true
  }
*/
}


/* 
Create Application Load Balancer with 2 target groups:

target group 1: name=ghost-ec2,port=2368,protocol="HTTP"
target group 2: name=ghost-fargate,port=2368,protocol="HTTP"
Create ALB listener: port=80,protocol="HTTP", avalability zone=a,b,c

Edit ALB listener rule: action type = "forward",target_group_1_weight=50,target_group_2_weight=50

resource "aws_lb" "alb_ghost" {
  name               = "albghost"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
#  subnets           = [for subnet in aws_subnet.public : subnet.id]

  enable_deletion_protection = true

  subnet_mapping {
    subnet_id     = aws_subnet.public_a.id
  }

  subnet_mapping {
    subnet_id     = aws_subnet.public_b.id
  }

    subnet_mapping {
    subnet_id     = aws_subnet.public_c.id
  }

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "ghost-ec2" {
  name     = "ghost-ec2"
  port     = 2368
  protocol = "HTTP"
  vpc_id   = aws_vpc.cloudx.id
}

resource "aws_lb_target_group" "ghost-fargate" {
  name     = "ghost-fargate"
  port     = 2368
  protocol = "HTTP"
  vpc_id   = aws_vpc.cloudx.id
}

resource "aws_lb_listener" "alb_ghost" {
  load_balancer_arn = aws_lb.alb_ghost.arn
  port              = "80"
  protocol          = "HTTP"

default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
#  error At least 1 "condition" blocks are required.│Blocks of type "condition" are not expected here.

resource "aws_lb_listener_rule" "alb_ghost_rule" {
  listener_arn = aws_lb_listener.alb_ghost.arn
  priority     = 99

  action {
    type = "forward"
    forward {
      target_group {
        arn    = aws_lb_target_group.ghost-ec2-tg.arn
        weight = 50
      }

      target_group {
        arn    = aws_lb_target_group.ghost-fargate-tg.arn
        weight = 50
      }
      stickiness {
        enabled  = true
        duration = 600
      }

    condition {
      host_header {
        values = ["alb_ghost_rule"]
    }
      }
    }
  }
}
*/