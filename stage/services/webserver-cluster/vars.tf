variable "port_num" {
  default = 8080
  }

variable "region" {
  default = "us-west-2"
  }

variable "public_key_path" {
  default = "~/.ssh/mykey.pub"
  }

#variable "db_remote_state_key" {
#  description = "The name of the key in the S3 bucket used for the database's remote state storage"
#  }

#variable "db_remote_state_bucket" {
#  description = "The name of the S3 bucket used for the database's remote state storage"
#  }
