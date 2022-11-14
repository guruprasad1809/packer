variable "instance_type" {
  type    = string
}

variable "ami_name" {
    default = "packer-ubuntu-aws-{{timestamp}}"
}
 
variable "region" {}

variable "ami_regions" {
    default = ["eu-west-1", "us-west-1"]
}

source "amazon-ebs" "ubuntu" {
  ami_name      = var.ami_name
  instance_type = var.instance_type
  region      = var.region
  ami_regions   = var.ami_regions
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-xenial-16.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}

build {
  sources = ["source.amazon-ebs.ubuntu"]
}

