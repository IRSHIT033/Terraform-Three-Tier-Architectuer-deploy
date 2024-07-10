###    Data source   ###

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_key_pair" "terraform_key" {
  key_name           = "tf_key"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "local_file" "terraform_key_local_file" {
  content=tls_private_key.rsa.private_key_pem
  filename = "tfkey"
}

###    Ec2 Instance Web Tier   ###

resource "aws_instance" "ec2_public_web" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public-web-subnet-1.id
  vpc_security_group_ids = [aws_security_group.webserver-security-group.id]
  key_name               = aws_key_pair.terraform_key.key_name

  tags = {
    Name = "web-asg"
  }
}

#### EC2 instance APP Tier ###

resource "aws_instance" "ec2_private_app" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private-app-subnet-1.id
  vpc_security_group_ids = [aws_security_group.ssh-security-group.id]
  key_name               = aws_key_pair.terraform_key.key_name
  tags = {
    Name = "app-asg"
  }
}