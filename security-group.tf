provider "aws" {
  region = "us-east-1"  # Specify the AWS region
}

# Fetch the default VPC using filters
data "aws_vpc" "default" {
  filter {
    name   = "isDefault"
    values = ["true"]
  }
}

resource "aws_security_group" "example" {
  name        = "example-sg"
  description = "Example security group with inbound and outbound rules"
  vpc_id      = data.aws_vpc.default.id  # Reference to the default VPC

  # Inbound rules
  ingress {
    from_port   = 22      # Allow SSH (port 22)
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from any IP address
  }

  ingress {
    from_port   = 80      # Allow HTTP (port 80)
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP from any IP address
  }

  # Outbound rules (Allow all traffic)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # All protocols
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic
  }
}

output "security_group_id" {
  value = aws_security_group.example.id
}

