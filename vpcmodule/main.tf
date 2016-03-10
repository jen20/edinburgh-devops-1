variable "vpc_cidr" {
    type = "string"
}

variable "public_subnets" {
    type = "string"
}

variable "private_subnets" {
    type = "string"
}

resource "aws_vpc" "test" {
    cidr_block = "${var.vpc_cidr}"

    tags {
        Name = "Test VPC"
        Environment = "Staging"
    }
}

resource "aws_subnet" "private" {
    count = 3

    vpc_id = "${aws_vpc.test.id}"
    cidr_block = "${element(split(",", var.private_subnets), count.index)}"

    tags {
        Name = "${format("Private Subnet %d", count.index + 1)}"
    }
}

resource "aws_subnet" "public" {
    count = 3

    vpc_id = "${aws_vpc.test.id}"
    cidr_block = "${element(split(",", var.public_subnets), count.index)}"
    map_public_ip_on_launch = true

    tags {
        Name = "${format("Public Subnet %d", count.index + 1)}"
    }
}

output "vpc_id" {
    value = "${aws_vpc.test.id}"
}

output "public_subnet_ids" {
    value = "${join(",", aws_subnet.public.*.id)}"
}

output "private_subnet_ids" {
    value = "${join(",", aws_subnet.private.*.id)}"
}
