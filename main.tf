provider "aws" {
  region  = "eu-west-1"
  profile = "leap-forward"
}


resource "aws_key_pair" "main" {
  key_name   = "victor-leap-forward-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDifE4m9+hGh984+jXR6x2HOS1s2s+Ji8rzxo1wDmlOzVM4MUXMWx36BJtwpM1eGDnhCJwQ31z7KhYapSrvD6o+FL0TtFtpN8+cbmaNTUWa6mk1IwC6olGomEt04kSWWzqk22IuXhC9KN2BrRo2DWRiawCWg1jQQvICP33pLgWc58KGrxxsOKM2UtMby9ATIAAwjc/WOiOGXvsKG/Y111vu+NhcwimXHHozuIdh659S1/lypx/nzObmTGNtgxeHYtfvYjYrZkslxMe3kJps5bJnDQKD39B5y05kgZoFZ30gH3FYK0ntchXlNOqd7pPmqnbyI+HP1CTxHRXHJN8CwxRGW3bj9KsgCXog/c4xO3zIN0yJZnd4o7tb8Q4lj/PssJ4yd7DOBwKYAe8q68UIy1ReKVm05WGPpdREq+PNJFN7wweeRzbVJPk0FijjVe1j5FEAmu/jCkU+ETeHPQwUg1HyAe5DUCrvwF6hDRMJBxgxaRD6F+Kg0pkT8I5Fj19WuDtyhtlRgJ3yg3+dY+I+CNeaFrlwBT5a+x1flIYRkHBhiIinWtq925bEcCYihp30VhtSCi7Cw34mB39K4FEJORV2QYZNWqY8nIqg+Mq3kzejKSGOqKXxcbe3072KsjUwGOSbSMixPNfbEnPeuYPnTVFfUa3vuAxVBkQGspdZgT+LTQ== victor.fernandez@opencredo.com"
}

resource "aws_security_group" "etcd-servers" {
  name = "victorf-leap-forward-etcd-servers"
  description = "Allow incoming ssh and etcd client port"
  vpc_id = "${aws_vpc.main.id}"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "etcd-servers-sg"
  }
}

resource "aws_instance" "etcd-servers" {
  ami = "${var.ami}"
  key_name = "${aws_key_pair.main.key_name}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.public-subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.etcd-servers.id}"]
  associate_public_ip_address = true
  root_block_device {
    delete_on_termination = true
  }

  tags {
    Name = "victorf-leap-forward-etcd"
  }
}