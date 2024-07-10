resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.three_tier_app_vpc.id
  tags = {
    Name = "Internet Gateway"
  }
}