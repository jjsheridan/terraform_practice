provider "aws" {
	region = "${var.region}"
	}

data "aws_caller_identity" "current" {}

#data "aws_s3_bucket" "selected" {
#	bucket = "tfstate-${data.aws_caller_identity.current.account_id}-${var.region}"

resource "aws_s3_bucket" "tf-state-bucket" {
	bucket = "tfstate-${data.aws_caller_identity.current.account_id}-${var.region}"
	acl = "private"
	force_destroy = true
	versioning {
		enabled = true
		}

	lifecycle {
		prevent_destroy = false
		}

	tags {
		Name = "S3 Remote Terraform State Store"
    }
	}
