resource "aws_instance" "example_instance" {
  ami           = "ami-002f6e91abff6eb96"  # Replace with a valid AMI ID for your region
  instance_type = "t2.micro"
  key_name      = "main-machine-key"  # Replace with your key pair name

  security_groups = [aws_security_group.example_sg.name]

  tags = {
    Name        = "example-instance"
  }
}
