variable "port_num" {
    default = 8080
  }

variable "public_key_path" {
    default = "~/.ssh/mykey.pub"
    }

provider "aws" {
    region = "us-west-2"
  }

resource "aws_launch_configuration" "alc" {
    image_id = "ami-0a00ce72"
    instance_type = "t2.nano"
    key_name = "mykey"
    security_groups = ["${aws_security_group.ec2-sg.id}"]    

    user_data = <<-EOF
        #!/bin/bash
        echo "Hello, World" > index.html
	nohup busybox httpd -f -p "${var.port_num}" &
	EOF

lifecycle {
    create_before_destroy = true
  }
}

resource "aws_key_pair" "mykey" {
    key_name = "mykey"
    public_key = "${file("~/.ssh/mykey.pub")}"
  }

resource "aws_security_group" "ec2-sg" {
    name = "terraform-ec2-instance"
    ingress {
      from_port = "${var.port_num}"
      to_port = "${var.port_num}"
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  
  lifecycle {
  create_before_destroy = true
  }
} 
resource "aws_security_group" "alb-sg" {
    name = "terraform-alb-sg"
    
    ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
    egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

lifecycle {
    create_before_destroy = true
  }
}


data "aws_availability_zones" "all" {}

resource "aws_autoscaling_group" "asg" {
    launch_configuration = "${aws_launch_configuration.alc.id}"
    availability_zones   = ["${data.aws_availability_zones.all.names}"]
    
    load_balancers = ["${aws_elb.myalb.name}"]
    health_check_type = "ELB"
    min_size = 2
    max_size = 3

    tag {
      key = "Name"
      value = "terraform-ec2"
      propagate_at_launch = true
  }
}

resource "aws_elb" "myalb" {
    name = "myalb"
    availability_zones = ["${data.aws_availability_zones.all.names}"]
    security_groups =  ["${aws_security_group.alb-sg.id}"]
    
    listener {
      lb_port = 80
      lb_protocol = "http"
      instance_port = "${var.port_num}"
      instance_protocol = "http"
  }

    health_check {
      healthy_threshold = 2
      unhealthy_threshold = 2
      timeout = 3
      interval = 30
      target = "HTTP:${var.port_num}/"
  }
}
