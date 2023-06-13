provider "aws" {
  version = ">= 3.63"
}

terraform {
  required_version = ">= 1.0.0"
  backend "s3" {
    key = "tf_state"
  }
}
