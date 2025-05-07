terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    random = {
      source = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  endpoints {
    ec2 = "http://ip10-0-12-4-d0dgr5005akh4glkf91g-4566.direct.lab-boris.fr"
    iam = "http://ip10-0-12-4-d0dgr5005akh4glkf91g-4566.direct.lab-boris.fr"
    sts = "http://ip10-0-12-4-d0dgr5005akh4glkf91g-4566.direct.lab-boris.fr"
  }
}

# Génére une valeur aléatoire pour forcer un changement d'AMI
resource "random_id" "ami_randomizer" {
  byte_length = 2
}

resource "aws_instance" "demo" {
  ami           = "ami-${random_id.ami_randomizer.hex}"
  instance_type = "t2.micro"

  tags = {
    Name = "LocalStackDemo"
  }
}

output "instance_id" {
  value = aws_instance.demo.id
}
