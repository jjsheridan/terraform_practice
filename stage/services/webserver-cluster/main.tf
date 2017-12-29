provider "aws" {
    region = "${var.region}"
}

data "aws_caller_identity" "current" {}

module "webserver-cluster" {
    source = "../../../modules/services/webserver-cluster"

    cluster_name            = "${var.cluster_name}"
    db_remote_state_bucket  = "tfstate-${data.aws_caller_identity.current.account_id}-${var.region}"
    db_remote_state_key     = "stage/data-stores/mysql/terraform.tfstate"
    port_num                = "${var.port_num}"
    instance_type           = "t2.micro"
    min_size                = 2
    max_size                = 2
}

resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
  scheduled_action_name = "scale-out-during-business-hours"
  min_size              = 2
  max_size              = 3
  desired_capacity      = 3
  recurrence            = "0 9 * * *"

  autoscaling_group_name = "${module.webserver-cluster.asg_name}"
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
  scheduled_action_name = "scale-in-at-night"
  min_size              = 2
  max_size              = 10
  desired_capacity      = 2
  recurrence            = "0 17 * * *"

  autoscaling_group_name = "${module.webserver-cluster.asg_name}"
}
