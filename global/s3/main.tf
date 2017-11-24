provider "aws" {
	region = "us-west-2"
	}
variable "region" {
	default = "us-west-2"
	}
	
#terraform {
#	backend "s3" { }
#	}
	
#data "aws_s3_bucket" "selected" {
#	bucket = "tfstate-${data.aws_caller_identity.current.account_id}-${var.region}"
#	}

data "aws_caller_identity" "current" {}
	
resource "aws_s3_bucket" "tf-state-bucket" {
	bucket = "tfstate-${data.aws_caller_identity.current.account_id}-${var.region}"
	acl = "private"
	versioning {
		enabled = true
		}
	
	lifecycle {
		prevent_destroy = true
		}
	}

resource "aws_dynamodb_table" "terraform_statelock"	{
	name		= "statelock"
	read_capacity = 1
	write_capacity = 1
	hash_key 	= "LockId"
	
	attribute {
	  name = "LockId"
	  type = "S"
	  }
	 }

#	 Retrieves state meta data from a remote backend
#data "terraform_remote_state" "mybucket"	{
#	backend = "s3"
#	config {
#	  encrypt = "true"
#	  bucket = "tfstate-${data.aws_caller_identity.current.account_id}-${var.region}"
#	  key = "mybucket/terraform.tfstate"
#	  region = "us-west-2"
#	  }
#	}
	
