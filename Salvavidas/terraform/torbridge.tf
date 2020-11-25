provider "aws" {
  region = var.AWS_ZONE
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


resource "aws_instance" "torbridge" {
  count           = var.COUNT
  ami             = data.aws_ami.ubuntu.id
  instance_type   = var.MACHINE_TYPE
  security_groups = [aws_security_group.torbridge_sg.name]
  tags = {
    Name = "TorBridge${count.index}"
    Type = "Ogre"
  }

  depends_on = [aws_security_group.torbridge_sg]

}


resource "aws_security_group" "torbridge_sg" {
  name        = "torbridge_sg"
  description = "Allow bridge-related trafic"

  ingress {
    description = "ORport"
    from_port   = var.ORPORT
    to_port     = var.ORPORT
    protocol    = "tcp"
  }

  ingress {
    description = "ORport"
    from_port   = var.ORPORT
    to_port     = var.ORPORT
    protocol    = "udp"
  }

  ingress {
    description = "ORport"
    from_port   = var.OBFS4PORT
    to_port     = var.OBFS4PORT
    protocol    = "tcp"
  }

  ingress {
    description = "ORport"
    from_port   = var.OBFS4PORT
    to_port     = var.OBFS4PORT
    protocol    = "udp"
  }


  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
  }
}


output "ips" {
  value = [aws_instance.torbridge.*.public_ip]
}
