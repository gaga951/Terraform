resource "aws_db_subnet_group" "ghost" {
  name        = "ghost"
  subnet_ids  = [aws_subnet.private_db_a.id, aws_subnet.private_db_b.id, aws_subnet.private_db_c.id]
  description = "ghost database subnet group"

  tags = {
    Name = "ghost database subnet group"
  }
}

resource "aws_db_instance" "ghost" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t2.micro"
  db_name                = "ghost"
  password               = var.database_master_password
  username               = var.database_master_user
  db_subnet_group_name   = aws_db_subnet_group.ghost.id
  vpc_security_group_ids = [aws_security_group.mysql.id]
  skip_final_snapshot    = true
}

resource "aws_ssm_parameter" "secret" {
  name        = "/ghost/dbpassw"
  description = "DB User password"
  type        = "SecureString"
  value       = var.database_master_password
  # value       = random_password.database_master_password.result

  tags = {
    environment = "ghost_DB"
  }
}

resource "random_password" "database_master_password" {
  length           = 16
  special          = true
  override_special = "_%@"
}