resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  #enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}
# crear subnets publicas
resource "aws_subnet" "public_subnet" {
  for_each = toset(var.availability_zones) # Una subnet pública por cada zona de disponibilidad
  vpc_id   = aws_vpc.this.id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, index(tolist(var.availability_zones), each.key))
  map_public_ip_on_launch = true  # Esto asegura que las instancias reciban una IP pública
  availability_zone = each.value

  tags = {
    Name = var.gateway_name
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = var.route_table_name
  }
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.public_rt.id
}
