#   NAT Gateway #
resource "aws_eip" "eip_nat" {
  domain = "vpc"

  tags = {
    Name = "Elastic IP for Nat Gateway"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.eip_nat.id
  subnet_id     = aws_subnet.public-web-subnet-2.id

  tags = {
    Name = "Nat Gateway"
  }
}