terraform {
	backend "s3" {
    bucket = "tfstate-494937358541-us-west-2"
#		bucket	= "tfstate-${data.aws_caller_identity.current.account_id}-${var.region}"
		encrypt = true
		dynamodb_table = "tf-statelock"
		key	= "global/s3/terraform.tfstate"
    region = "us-west-2"
  	}
	}
