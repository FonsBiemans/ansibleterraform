provider "aws" {

  shared_credentials_file = "~/.aws/creds"
  region     = "eu-west-1"
}
terraform {
  backend "s3" {
  bucket = "terraform-fons"
  region = "eu-west-1" 
  key = "statejenkins.tfstate" 
  }
}
