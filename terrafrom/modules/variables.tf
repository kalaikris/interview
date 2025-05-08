variable "ami_id" {}
variable "instance_type" {}
variable "vpc_id" {}
variable "private_subnet_ids" { type = list(string) }
variable "target_group_arns" { type = list(string) }
variable "user_data" {
  type = string
}

