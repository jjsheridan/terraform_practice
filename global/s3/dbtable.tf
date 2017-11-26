resource "aws_dynamodb_table" "terraform_statelock"	{
	name		= "tf-statelock"
	read_capacity = 10
	write_capacity = 10
	hash_key 	= "LockID"

	attribute {
	  name = "LockID"
	  type = "S"
	  }
	 }
