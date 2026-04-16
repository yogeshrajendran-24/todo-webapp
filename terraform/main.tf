resource "aws_security_group" "web_sg" {
  name = "todo-webapp-sg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
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

resource "aws_instance" "app" {
  ami                    = "ami-0f6a202861f7f12a8"
  instance_type          = "t3.small"
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name = "todo-key"

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y docker.io
              systemctl start docker
              systemctl enable docker
              usermod -aG docker ubuntu
              EOF

  tags = {
    Name = "todo-webapp"
  }
}