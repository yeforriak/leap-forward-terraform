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

resource "aws_route_table" "main" {
    vpc_id = "${aws_vpc.main.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.main.id}"
    }

    tags {
        Name = "victorf-leap-forward-public-subnet"
    }
}