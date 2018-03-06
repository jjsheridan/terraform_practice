variable "db_password" {}

provider "aws" {
    region = "${var.region}"
  }

data "aws_caller_identity" "current" {}

module "mysql" {
    source = "git::https://github.com/jjsheridan/terraform_practice_modules.git//data-stores/mysql/"
    db_password = "${var.db_password}"
}
