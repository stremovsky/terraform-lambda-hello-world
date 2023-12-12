variable "private_key_path" {
  type = string
  default = "~/.ssh/terraform_rsa"
}

variable "public_key" {
  type = string
  default = "ssh-rsa terraform_public_key"
}

variable "zones" {
  type = map
  default = {
    "oregon"    = "us-west-2"
    "london"    = "uk-lon1"
    "frankfurt" = "de-fra1"
  }
}

provider "aws" {
  region                   = var.zones["oregon"]
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "prod"
}
