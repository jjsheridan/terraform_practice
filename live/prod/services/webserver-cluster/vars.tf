variable "port_num" {
  default = 8080
  }

variable "region" {
  default = "us-west-2"
  }

variable "cluster_name" {
    description = "The name to use for all the cluster resources"
    default     = "webservers-prod-cluster"
  }
