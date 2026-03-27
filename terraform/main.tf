terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-3"  # Paris
}

# Clé SSH
resource "aws_key_pair" "nginx_key" {
  key_name   = "nginx-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

# Security Group
resource "aws_security_group" "nginx_sg" {
  name        = "nginx-sg"
  description = "SSH + HTTP"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance (Free Tier t3.micro)
resource "aws_instance" "nginx_vm" {
  ami                    = "ami-0ad53ba8e49f41b76"  # Ubuntu 22.04 LTS Paris
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.nginx_key.key_name
  vpc_security_group_ids = [aws_security_group.nginx_sg.id]

  tags = {
    Name = "nginx-server"
  }
}
