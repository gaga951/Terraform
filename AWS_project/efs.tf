resource "aws_efs_file_system" "foo_with_lifecyle_policy" {
  creation_token = "ghost_content"
  tags = {
    Name = "ghost_content"
  }
}
resource "aws_efs_mount_target" "ghost_content_a" {
  file_system_id  = aws_efs_file_system.foo_with_lifecyle_policy.id
  subnet_id       = aws_subnet.private_a.id
  security_groups = [aws_security_group.efs.id]
}
resource "aws_efs_mount_target" "ghost_content_b" {
  file_system_id  = aws_efs_file_system.foo_with_lifecyle_policy.id
  subnet_id       = aws_subnet.private_b.id
  security_groups = [aws_security_group.efs.id]
}
resource "aws_efs_mount_target" "ghost_content_c" {
  file_system_id  = aws_efs_file_system.foo_with_lifecyle_policy.id
  subnet_id       = aws_subnet.private_c.id
  security_groups = [aws_security_group.efs.id]
}
/*
resource "aws_efs_file_system" "foo_with_lifecyle_policy_a" {
  creation_token = "ghost_content_a"
  availability_zone_name = "us-east-1a"

  tags = {
    Name = "ghost_content"
  }
}

resource "aws_efs_file_system" "foo_with_lifecyle_policy_b" {
  creation_token = "ghost_content_b"
  availability_zone_name = "us-east-1b"

  tags = {
    Name = "ghost_content"
  }
}

resource "aws_efs_file_system" "foo_with_lifecyle_policy_c" {
  creation_token = "ghost_content_c"
  availability_zone_name = "us-east-1c"

  tags = {
    Name = "ghost_content"
  }
}

resource "aws_efs_mount_target" "ghost_content_a" {
  file_system_id  = aws_efs_file_system.foo_with_lifecyle_policy_a.id
  subnet_id = aws_subnet.private_a.id
  security_groups = [aws_security_group.efs.id]
}

resource "aws_efs_mount_target" "ghost_content_b" {
  file_system_id  = aws_efs_file_system.foo_with_lifecyle_policy_b.id
  subnet_id = aws_subnet.private_b.id
  security_groups = [aws_security_group.efs.id]
}

resource "aws_efs_mount_target" "ghost_content_c" {
  file_system_id  = aws_efs_file_system.foo_with_lifecyle_policy_c.id
  subnet_id = aws_subnet.private_c.id
  security_groups = [aws_security_group.efs.id]
}
*/