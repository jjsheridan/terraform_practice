 variable "port_num" {}

variable "cluster_name" {
  description = "The name to use for all the cluster resources"
}

variable "db_remote_state_bucket" {
  description = "The name of the S3 bucket for the database's remote state"
}

variable "db_remote_state_key" {
  description = "The path for the database's remote state in S3"
}

variable "instance_type" {
  description = "The type of EC2 Instances to run (e.g. t2.micro)"
}

variable "min_size" {
  description = "The minimum number of EC2 Instances in the ASG"
}

variable "max_size" {
  description = "The maximum number of EC2 Instances in the ASG"
}

variable "enable_autoscaling" {
  description = "If set to true, enable auto scaling"
}

variable "ami" {
  description = "The AMI to run in the cluster"
}

variable  "server_words" {
  description = "The text the web server should return"
}
