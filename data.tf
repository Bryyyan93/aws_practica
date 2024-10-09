data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

data "http" "my_ip" {
  url = "https://checkip.amazonaws.com/"
}