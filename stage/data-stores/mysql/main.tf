variable "db_password" {}

provider "aws" {
    region = "${var.region}"
  }

data "aws_caller_identity" "current" {}

module "mysql" {
    source = "../../../modules/data-stores/mysql"
    db_password = "${var.db_password}"
}
