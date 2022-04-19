/*
1) name=ec2_pool, description="allows access for ec2 instances":
ingress rule_1: port=22, source={your_ip}, protocol=tcp
ingress rule_2: port=2049, source={vpc_cidr}, protocol=tcp
ingress rule_3: port=2368, source_security_group={alb}, protocol=tcp
egress rule: allows any destination
*/
resource "aws_security_group" "ec2_pool" {
  name        = "ec2_pool"
  description = "allows access for ec2 instances"
  vpc_id      = aws_vpc.cloudx.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.your_ip]
  }

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.cloudx.cidr_block]
  }

  ingress {
    from_port = 2368
    to_port   = 2368
    protocol  = "tcp"
    self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2_pool"
  }
}

/*
2) name=fargate_pool, description="allows access for fargate instances":
ingress rule_1: port=2049, source={vpc_cidr}, protocol=tcp
ingress rule_2: port=2368, source_security_group={alb}, protocol=tcp
egress rule: allows any destination
*/
resource "aws_security_group" "fargate_pool" {
  name        = "fargate_pool"
  description = "allows access for fargate instances"
  vpc_id      = aws_vpc.cloudx.id

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.cloudx.cidr_block]
  }

  ingress {
    from_port = 2368
    to_port   = 2368
    protocol  = "tcp"
    self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "fargate_pool"
  }
}

/*
3) name=mysql, description="defines access to ghost db":
ingress rule_1: port=3306, source_security_group={ec2_pool}, protocol=tcp
ingress rule_2: port=3306, source_security_group={fargate_pool}, protocol=tcp
*/
resource "aws_security_group" "mysql" {
  name        = "mysql"
  description = "defines access to ghost db"
  vpc_id      = aws_vpc.cloudx.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_pool.id]
  }

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.fargate_pool.id]
  }

  tags = {
    Name = "mysql"
  }
}

/*
4) name=efs, description="defines access to efs mount points":
ingress rule_1: port=2049, source_security_group={ec2_pool}, protocol=tcp
ingress rule_2: port=2049, source_security_group={fargate_pool}, protocol=tcp
egress rule: allows any destination to {vpc_cidr}
*/
resource "aws_security_group" "efs" {
  name        = "efs"
  description = "defines access to efs mount points"
  vpc_id      = aws_vpc.cloudx.id

  ingress {
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_pool.id]
  }

  ingress {
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    security_groups = [aws_security_group.fargate_pool.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.cloudx.cidr_block]
  }

  tags = {
    Name = "efs"
  }
}

/*
5) name=alb, description="defines access to alb":
ingress rule_1: port=80, source={your_ip}, protocol=tcp
egress rule 1: port=any, source_security_group={ec2_pool}, protocol=any
egress rule 2: port=any, source_security_group={fargate_pool}, protocol=any
*/
resource "aws_security_group" "alb" {
  name        = "alb"
  description = "defines access to alb"
  vpc_id      = aws_vpc.cloudx.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.your_ip]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.ec2_pool.id]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.fargate_pool.id]
  }

  tags = {
    Name = "alb"
  }
}

/*
6) name=vpc_endpoint, description="defines access to vpc endpoints":
ingress rule_1: port=443, source={vpc_cidr}, protocol=tcp
*/
resource "aws_security_group" "vpc_endpoint" {
  name        = "vpc_endpoint"
  description = "defines access to vpc endpoints"
  vpc_id      = aws_vpc.cloudx.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.cloudx.cidr_block]
  }

  tags = {
    Name = "vpc_endpoint"
  }
}