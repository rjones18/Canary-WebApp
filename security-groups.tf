resource "aws_security_group" "app_sg2" {
  name        = "app_sg"
  description = "Allow access to the server"
  vpc_id      = data.aws_vpc.main_vpc.id


  # INBOUND CONNECTIONS
  ingress {
    description = "allowd ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["69.222.131.250/32"]

  }

  ingress {
    description = "Allow HTTP into the EC2"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    #cidr_blocks = ["0.0.0.0/0"] # 0.0.0.0/0
    security_groups = [aws_security_group.loadbalancer_sg.id]
  }

  egress {
    description = "Allow access to the world"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" #TCP + UDP
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "loadbalancer_sg" {
  name        = "loadbalancer_sg"
  description = "Allow access to the server"
  vpc_id      = data.aws_vpc.main_vpc.id


  # INBOUND CONNECTIONS

  ingress {
    description = "Allow HTTP into the EC2"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # 0.0.0.0/0
  }

  egress {
    description = "Allow access to the world"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" #TCP + UDP
    cidr_blocks = ["0.0.0.0/0"]
  }
}