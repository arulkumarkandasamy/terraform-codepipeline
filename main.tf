terraform {
  backend "s3" {
    bucket = "iot-terraform-shared-state-storage-s3"
    dynamodb_table = "terraform-state-lock-dynamo"
    region = "eu-west-1"
    key = "project/terraform-codepipeline-example"
    profile = "root"
  }
}


provider "aws" {
  version = ">= 2.11.0"
  region  = "eu-west-1"
}
