provider "aws" {
    region = "${var.region}"
  }

data "aws_caller_identity" "current" {}

module "webserver-cluster" {
    source "../../../modules/services/webserver-cluster"

    cluster_name = "${var.cluster_name}"
    db_remote_state_bucket   = "tfstate-${data.aws_caller_identity.current.account_id}-${var.region}"
    db_remote_state_key      = "stage/data-stores/mysql/terraform.tfstate"
    port_num                 = "${var.port_num}"
    instance_type            = "t2.micro"
    min_size                 = 2
    max_size                 = 2
    enable_autoscaling       = false
    enable_new_user_data     = false
  }
