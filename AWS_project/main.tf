resource "aws_vpc" "cloudx" {
  cidr_block           = "10.10.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "cloudx"
  }
}

resource "aws_subnet" "public_a" {
  availability_zone = "us-east-1a"
  vpc_id            = aws_vpc.cloudx.id
  map_public_ip_on_launch = true
  cidr_block        = "10.10.1.0/24"
  tags = {
    Name = "public_a"
  }
}

resource "aws_subnet" "public_b" {
  availability_zone = "us-east-1b"
  vpc_id            = aws_vpc.cloudx.id
  map_public_ip_on_launch = true
  cidr_block        = "10.10.2.0/24"
  tags = {
    Name = "public_b"
  }
}

resource "aws_subnet" "public_c" {
  availability_zone = "us-east-1c"
  vpc_id            = aws_vpc.cloudx.id
  map_public_ip_on_launch = true
  cidr_block        = "10.10.3.0/24"
  tags = {
    Name = "public_c"
  }
}

resource "aws_subnet" "private_a" {
  availability_zone = "us-east-1a"
  vpc_id            = aws_vpc.cloudx.id
  cidr_block        = "10.10.10.0/24"
  tags = {
    Name = "private_a"
  }
}

resource "aws_subnet" "private_b" {
  availability_zone = "us-east-1b"
  vpc_id            = aws_vpc.cloudx.id
  cidr_block        = "10.10.11.0/24"
  tags = {
    Name = "private_b"
  }
}

resource "aws_subnet" "private_c" {
  availability_zone = "us-east-1c"
  vpc_id            = aws_vpc.cloudx.id
  cidr_block        = "10.10.12.0/24"
  tags = {
    Name = "private_c"
  }
}

resource "aws_subnet" "private_db_a" {
  availability_zone = "us-east-1a"
  vpc_id            = aws_vpc.cloudx.id
  cidr_block        = "10.10.20.0/24"
  tags = {
    Name = "private_db_a"
  }
}

resource "aws_subnet" "private_db_b" {
  availability_zone = "us-east-1b"
  vpc_id            = aws_vpc.cloudx.id
  cidr_block        = "10.10.21.0/24"
  tags = {
    Name = "private_db_b"
  }
}

resource "aws_subnet" "private_db_c" {
  availability_zone = "us-east-1c"
  vpc_id            = aws_vpc.cloudx.id
  cidr_block        = "10.10.22.0/24"
  tags = {
    Name = "private_db_c"
  }
}

# Create IGW
resource "aws_internet_gateway" "cloudx-igw" {
  vpc_id = aws_vpc.cloudx.id
  tags = {
    Name = "cloudx-igw"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.cloudx.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cloudx-igw.id
  }

  tags = {
    Name = "public_rt"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.cloudx.id

  route = []

  tags = {
    Name = "private_rt"
  }
}