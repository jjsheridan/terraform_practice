terraform {
	backend "s3" {
    bucket = "tfstate-494937358541-us-west-2"
#		bucket	= "tfstate-${data.aws_caller_identity.current.account_id}-${var.region}"
		encrypt = true
		dynamodb_table = "tf-statelock"
		key	= "stage/services/webserver-cluster/terraform.tfstate"
    region = "us-west-2"
  	}
	}
