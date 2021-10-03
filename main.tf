terraform {
    required_providers {
      aws = {
          source = "hashicorp/aws"
          version = "~> 3.61"
      }
    }
    required_version = ">= 1.0.8"
}

provider "aws" {
    profile = "default"
    region = var.region_1
}

module "S3" {
    source = "./modules/S3"

}

module "Lambda" {
    source = "./modules/Lambda"
}

module "ApiGateway" {
    source = "./modules/ApiGateway"
}