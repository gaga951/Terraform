/*data "aws_caller_identity" "current" {}

resource "aws_vpc_endpoint_service" "endpoint_service" {
  acceptance_required        = false
  allowed_principals         = [data.aws_caller_identity.current.arn]
  gateway_load_balancer_arns = [aws_lb.ghost_lb.arn]
}

resource "aws_vpc_endpoint" "s3-vpc-endpoint" {
  service_name      = aws_vpc_endpoint_service.endpoint_service.service_name
  subnet_ids        = [aws_subnet.private_a.id, aws_subnet.private_b.id, aws_subnet.private_c.id]
  vpc_endpoint_type   = "Interface"
  vpc_id            = aws_vpc.cloudx.id
}

resource "aws_vpc_endpoint" "efs-vpc-endpoint" {
  service_name      = aws_vpc_endpoint_service.endpoint_service.service_name
  subnet_ids        = [aws_subnet.private_a.id, aws_subnet.private_b.id, aws_subnet.private_c.id]
  vpc_endpoint_type   = "Interface"
  vpc_id            = aws_vpc.cloudx.id
}

resource "aws_vpc_endpoint" "ecr-vpc-endpoint" {
  service_name      = aws_vpc_endpoint_service.endpoint_service.service_name
  subnet_ids        = [aws_subnet.private_a.id, aws_subnet.private_b.id, aws_subnet.private_c.id]
  vpc_endpoint_type   = "Interface"
  vpc_id            = aws_vpc.cloudx.id
}

resource "aws_vpc_endpoint" "ssm-vpc-endpoint" {
  service_name      = aws_vpc_endpoint_service.endpoint_service.service_name
  subnet_ids        = [aws_subnet.private_a.id, aws_subnet.private_b.id, aws_subnet.private_c.id]
  vpc_endpoint_type   = "Interface"
  vpc_id            = aws_vpc.cloudx.id
}


/*

module "endpoints" {
  source = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  vpc_id             = "aws_vpc.cloudx.id"
  security_group_ids = ["aws_security_group.vpc_endpoint.id"]
  endpoints = {
    s3 = {
      # interface endpoint
      service            = "s3"
      security_group_ids = ["aws_security_group.vpc_endpoint.id"]
      subnet_ids         = ["aws_subnet.private_a.id, aws_subnet.private_b.id, aws_subnet.private_c.id"]
      tags               = { Name = "s3-vpc-endpoint" }
    },
    efs = {
      # gateway endpoint
      service            = "efs"
      route_table_ids    = ["rt-12322456", "rt-43433343", "rt-11223344"]
      security_group_ids = ["aws_security_group.vpc_endpoint.id"]
      subnet_ids         = ["aws_subnet.private_a.id, aws_subnet.private_b.id, aws_subnet.private_c.id"]
      tags               = { Name = "efs-vpc-endpoint" }
    },
    ecr = {
      service            = "ecr"
      subnet_ids         = ["subnet-12345678", "subnet-87654321"]
      security_group_ids = ["aws_security_group.vpc_endpoint.id"]
      subnet_ids         = ["aws_subnet.private_a.id, aws_subnet.private_b.id, aws_subnet.private_c.id"]
      tags               = { Name = "ecr-vpc-endpoint" }
    },
    ssm = {
      service             = "ssm"
      private_dns_enabled = true
      security_group_ids  = ["aws_security_group.vpc_endpoint.id"]
      subnet_ids          = ["aws_subnet.private_a.id, aws_subnet.private_b.id, aws_subnet.private_c.id"]
      tags                = { Name = "ssm-vpc-endpoint" }
    },
  }
  tags = {
    Owner       = "user"
    Environment = "dev"
  }
}

*/