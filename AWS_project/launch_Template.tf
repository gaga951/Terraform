resource "aws_launch_template" "ghost_template" {
  name          = "ghost"
  image_id      = "ami-033b95fb8079dc481"
  instance_type = "t2.micro"
  key_name      = var.key_name
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }
  monitoring {
    enabled = true
  }
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.ec2_pool.id]
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "ghost"
    }
  }
  user_data = filebase64("${path.module}/ghost_init.sh")
}
/*
name=ghost,
instance_type=t2.micro, 
security_group={ec2_pool.id}, 
key_name={ghost-ec2-pool}, 
userdata={your_startup_script}, 
iam_role_profile={ghost_app}

#===============================================
resource "aws_launch_template" "ghost_template" {
  name = "ghost"

  image_id = "ami-033b95fb8079dc481"

  instance_type = "t2.micro"

  key_name = var.key_name

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  monitoring {
    enabled = true
  }
  
  network_interfaces {
    associate_public_ip_address = true
  }

 vpc_security_group_ids = [aws_security_group.ec2_pool.id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "ghost"
    }
  }

  user_data = filebase64("${path.module}/ghost_init.sh")
}

#===============================================
resource "aws_launch_template" "ghost" {
    name                   = "ghost"
    image_id               = "ami-033b95fb8079dc481"
    instance_type          = "t2.micro"
    vpc_security_group_ids = [aws_security_group.ec2_pool.id]
    key_name               = "var.key_name"
    user_data              = filebase64("${path.module}/ghost_init.sh")
    iam_instance_profile {
    name = "ghost_app"
  }
}
#===============================================
resource "aws_instance" "ghost" {
    ami               = "ami-033b95fb8079dc481"
    instance_type          = "t2.micro"
    vpc_security_group_ids = [aws_security_group.ec2_pool.id]
    key_name               = "var.key_name"
    user_data              = filebase64("${path.module}/ghost_init.sh")
    iam_instance_profile   = "ghost_app"

    tags = {
        Name = "ghost"
    } 
}
*/