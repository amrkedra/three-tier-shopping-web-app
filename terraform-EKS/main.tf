resource "aws_vpc" "shopping-app" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "shopping-app"
  }
}

resource "aws_subnet" "shopping-app-private-subnet-az1" {
  vpc_id     = aws_vpc.shopping-app.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "me-south-1a"

  tags = {
    Name = "shopping-app-private-subnet-az1"
  }
}

resource "aws_subnet" "shopping-app-private-subnet-az2" {
  vpc_id     = aws_vpc.shopping-app.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "me-south-1b"

  tags = {
    Name = "shopping-app-private-subnet-az2"
  }
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "shopping-app-NATGatewayEIP"
  }
}

resource "aws_internet_gateway" "shopping_app_igw" {
  vpc_id = aws_vpc.shopping-app.id

  tags = {
    Name = "shopping-app-InternetGateway"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.shopping-app-private-subnet-az1.id

  tags = {
    Name = "shopping-app-NATGateway"
  }

  depends_on = [aws_internet_gateway.shopping_app_igw]
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.shopping-app.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "shopping-app-PrivateRouteTable"
  }
}

resource "aws_route_table_association" "private_assoc_az1" {
  subnet_id      = aws_subnet.shopping-app-private-subnet-az1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_assoc_az2" {
  subnet_id      = aws_subnet.shopping-app-private-subnet-az2.id
  route_table_id = aws_route_table.private.id
}

resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  tags = {
    Name = "EKS-Cluster-Role"
  }
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

resource "aws_eks_cluster" "shopping_app_cluster" {
  name = "3-tier-shopping-app"

  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.shopping-app-private-subnet-az1.id,
      aws_subnet.shopping-app-private-subnet-az2.id
    ]
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy
  ]
}

resource "aws_eks_node_group" "shopping_app_node_group" {
  cluster_name    = aws_eks_cluster.shopping_app_cluster.name
  node_group_name = "shopping_app_node_group"
  node_role_arn   = aws_iam_role.eks_cluster_role.arn

  # Use multiple subnets for the node group
  subnet_ids = [
    aws_subnet.shopping-app-private-subnet-az1.id,
    aws_subnet.shopping-app-private-subnet-az2.id
  ]

  scaling_config {
    desired_size = 3
    max_size     = 6
    min_size     = 3
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_eks_cluster.shopping_app_cluster
  ]
}

