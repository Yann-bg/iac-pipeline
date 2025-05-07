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

# Génère un ID aléatoire à chaque exécution
resource "random_id" "ami_id" {
  byte_length = 4
}

resource "aws_instance" "demo" {
  ami           = "ami-${random_id.ami_id.hex}" # Change à chaque run
  instance_type = "t2.micro"
  tags = {
    Name = "AutoInstance"
  }
}
