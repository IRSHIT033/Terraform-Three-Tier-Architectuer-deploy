resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.three_tier_app_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "Public Route Table"
  }
}

resource "aws_route_table_association" "public-subnet-1-route-association" {
  subnet_id      = aws_subnet.public-web-subnet-1.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "public-subnet-2-route-association" {
  subnet_id      = aws_subnet.public-web-subnet-2.id
  route_table_id = aws_route_table.public-route-table.id
}