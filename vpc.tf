resource "aws_vpc" "main" {
  cidr_block = "${var.vpc_cdir}"
  tags {
    Name = "victorf-leap-forward-vpc"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"
  tags {
    Name = "victorf-leap-forward-internet-gateway"
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.public_subnet_cidr}"
  tags {
    Name = "victorf-leap-forward-public-subnet"
  }
}

#Defining route table for the VPC, it needs to get associated to the public subnet
resource "aws_route_table" "all-from-internet-gateway" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }

  tags {
    Name = "victorf-leap-forward-public-subnet"
  }
}

resource "aws_route_table_association" "public-subnet-to-internet-gateway" {
  subnet_id = "${aws_subnet.public-subnet.id}"
  route_table_id = "${aws_route_table.all-from-internet-gateway.id}"
}



