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

resource "random_id" "unique" {
  byte_length = 2
}

resource "aws_instance" "demo" {
  ami           = "ami-${random_id.unique.hex}"  # change automatiquement à chaque plan/apply
  instance_type = "t2.micro"

  tags = {
    Name = "TerraformInstance-${random_id.unique.hex}"
  }
}

output "instance_id" {
  value = aws_instance.demo.id
}
