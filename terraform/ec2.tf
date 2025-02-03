resource "aws_security_group" "allow_ssh_docker" {
  name_prefix = "allow_ssh_docker_"

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

resource "aws_instance" "my_ec2" {
  ami                    = "ami-087fba4aa07ebd20f"
  instance_type           = "t3.micro"

  # Use the security group ID, not the name
  security_groups = [aws_security_group.allow_ssh_docker.id]

  tags = {
    Name = "Docker EC2 Instance"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install -y docker.io
              sudo systemctl enable docker
              sudo systemctl start docker
              sudo docker pull your-docker-image:latest
              sudo docker run -d --name my_container your-docker-image:latest
              EOF
}
