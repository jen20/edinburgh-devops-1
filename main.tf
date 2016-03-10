provider "aws" {
    region = "us-west-2"
}

module "production" {
    source = "./vpcmodule"

    vpc_cidr = "10.0.0.0/16"
    private_subnets = "10.0.1.0/24,10.0.2.0/24,10.0.3.0/24"
    public_subnets = "10.0.10.0/24,10.0.11.0/24,10.0.12.0/24"
}

module "staging" {
    source = "./vpcmodule"

    vpc_cidr = "10.0.0.0/16"
    private_subnets = "10.0.1.0/24,10.0.2.0/24,10.0.3.0/24"
    public_subnets = "10.0.10.0/24,10.0.11.0/24,10.0.12.0/24"
}

output "production_public_subnet_ids" {
    value = "${module.production.public_subnet_ids}"
}

output "staging_public_subnet_ids" {
    value = "${module.staging.public_subnet_ids}"
}
