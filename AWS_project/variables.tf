variable "aws_region" {
  description = "The AWS region."
  default     = "us-east-1"
}

variable "aws_region_list" {
  description = "AWS availability zones."
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "key_name" {
  default = "ghost_key"
}

variable "your_ip" {
  type    = string
  default = "0.0.0.0/0"
}
variable "alb-sg" {
  type    = string
  default = "0.0.0.0/0"
}
# export TF_VAR_database_master_password=Test_pass7898747
# export TF_VAR_database_master_user=dbuser1

variable "database_master_password" {
  type      = string
  sensitive = true
}

variable "database_master_user" {
  type      = string
  sensitive = true
}
/*
variable "ports"{
  list        = list(any)
  default     = [22, 2049, 2368, 3306, 80, 443]
}
*/