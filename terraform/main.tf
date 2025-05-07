provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  skip_credentials_validation = true
  endpoints {
    ec2 = "http://ip10-0-12-4-d0dgr5005akh4glkf91g-4566.direct.lab-boris.fr"
  }
}

resource "random_id" "ami_simulation" {
  byte_length = 2
}

resource "aws_instance" "demo" {
  ami           = "ami-${random_id.ami_simulation.hex}"
  instance_type = "t2.micro"

  tags = {
    Name = "demo"
    ImageID = "ami-${random_id.ami_simulation.hex}"
  }

  lifecycle {
    create_before_destroy = true
  }
}
