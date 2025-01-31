resource "aws_vpc" "shopping-app" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "shopping-app"
  }
}

resource "aws_subnet" "shopping-app-private-subnet" {
  vpc_id     = aws_vpc.shopping-app.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "shopping-app-private-subnet"
  }
}


# Create NAT Gateway in the first Public Subnet
resource "aws_eip" "nat_eip" {
  domain = "vpc"  # Use "vpc" to indicate this is for a VPC EIP

  tags = {
    Name = "shopping-app-NATGatewayEIP"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id  # Remove [0] since aws_eip.nat_eip is a single instance
  subnet_id     = aws_subnet.shopping-app-private-subnet.id  # Keep the index for the subnet as it uses count

  tags = {
    Name = "shopping-app-NATGateway"
  }
}

# Create Route Table for Private Subnets
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.mern_app_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "shopping-app-PrivateRouteTable"
  }
}

# Associate Private Route Table with Private Subnets
resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.shopping-app-private-subnet.id
  route_table_id = aws_route_table.private.id
}

