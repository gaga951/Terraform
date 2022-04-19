aws_db_instance.ghost: Creation complete after 5m24s [id=terraform-20220228151818900800000003]
╷
│ Error: Error creating Auto Scaling Group: InvalidQueryParameter: Invalid launch template: When a network interface is provided, the security groups must be a part of it.
│ 	status code: 400, request id: 699b40ab-6fd6-4ebb-b639-f1a4ebd283b3
│ 
│   with aws_autoscaling_group.asg_ghost,
│   on auto-scaling-Group.tf line 9, in resource "aws_autoscaling_group" "asg_ghost":
│    9: resource "aws_autoscaling_group" "asg_ghost" {

#==================================================

    Warning: Argument is deprecated
│ 
│   with aws_autoscaling_attachment.asg_attachment_ghost,
│   on auto-scaling-Group.tf line 38, in resource "aws_autoscaling_attachment" "asg_attachment_ghost":
│   38:   alb_target_group_arn   = aws_lb_target_group.ghost-ec2.arn
│ 
│ Use lb_target_group_arn instead
│ 
│ (and 2 more similar warnings elsewhere)

