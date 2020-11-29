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
  key_name   = var.KEY_NAME
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
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ORport"
    from_port   = var.ORPORT
    to_port     = var.ORPORT
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ORport"
    from_port   = var.OBFS4PORT
    to_port     = var.OBFS4PORT
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ORport"
    from_port   = var.OBFS4PORT
    to_port     = var.OBFS4PORT
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
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




resource "null_resource" "dependencies" {
  count = var.COUNT
  connection {
    host        = aws_instance.torbridge[count.index].public_ip
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("prova-node.pem")

  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt-get install python -y",
    ]
  }
  depends_on = [
    aws_instance.torbridge
  ]
}

output "ips" {
  value = [aws_instance.torbridge.*.public_ip]
}

