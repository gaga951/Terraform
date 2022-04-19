resource "aws_autoscaling_group" "asg_ghost" {
  vpc_zone_identifier = [aws_subnet.private_a.id, aws_subnet.private_b.id, aws_subnet.private_c.id]
  desired_capacity    = 3
  max_size            = 3
  min_size            = 1
  launch_template {
    id      = aws_launch_template.ghost_template.id
    version = "$Latest"
  }
}
resource "aws_autoscaling_attachment" "asg_attachment_ghost" {
  autoscaling_group_name = aws_autoscaling_group.asg_ghost.id
  lb_target_group_arn    = aws_lb_target_group.ghost-ec2.arn
}
/*
1) Create Auto-scaling group and assign it with Launch Template from #9:

name=ghost_ec2_pool
avalability zone=a,b,c
2) Attach ASG with {ghost-ec2} target group.

#===============================================
resource "aws_autoscaling_group" "asg_ghost" {
  availability_zones = ["us-east-1a","us-east-1b","us-east-1c"]
  desired_capacity   = 3
  max_size           = 3
  min_size           = 1

  launch_template {
    id      = aws_launch_template.ghost_template.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_attachment" "asg_attachment_ghost" {
  autoscaling_group_name = aws_autoscaling_group.asg_ghost.id
  lb_target_group_arn    = aws_lb_target_group.ghost-ec2.arn
}
*/