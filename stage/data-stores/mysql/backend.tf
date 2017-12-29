terraform {
	backend "s3" {
    bucket = "tfstate-494937358541-us-west-2"
		encrypt = true
		dynamodb_table = "tf-statelock"
		key	= "stage/data-stores/mysql/terraform.tfstate"
    region = "us-west-2"
  	}
	}
