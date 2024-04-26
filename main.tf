terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = "AKIA5BB6JKYMZAFYVAHE"
  secret_key = "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"
}

resource "aws_instance" "vm1" {
  ami                         = "ami-0ebf330ebbfac441d"
  subnet_id                   = "subnet-027e48d7954f1d051"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  key_name                    = "tkey"
  security_groups             = ["sg-06c31a4f30402c865"]
  user_data                   = file("./ntlm_enable.bat")
  get_password_data           = true
}

resource "null_resource" "vm1" {
  count = 1

  triggers = {
    password = "${rsadecrypt(aws_instance.vm1.*.password_data[count.index], file("tkey.pem"))}"
  }
}
