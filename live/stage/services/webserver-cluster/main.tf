provider "aws" {
    region = "${var.region}"
}

data "aws_caller_identity" "current" {}

module "webserver-cluster" {
    source = "git::https://github.com/jjsheridan/terraform_practice_modules.git//services/webserver-cluster?ref=v0.0.1"

    ami                     = "ami-a9d276c9"
    server_text             = "New server text"

    cluster_name            = "${var.cluster_name}"
    db_remote_state_bucket  = "tfstate-${data.aws_caller_identity.current.account_id}-${var.region}"
    db_remote_state_key     = "stage/data-stores/mysql/terraform.tfstate"
    port_num                = "${var.port_num}"

    instance_type           = "t2.micro"
    min_size                = 2
    max_size                = 2
    enable_autoscaling      = false
}
