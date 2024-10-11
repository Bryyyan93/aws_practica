resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = false

  tags = {
    Name = var.vpc_name
  }
}
/*
resource "aws_subnet" "private_subnet" {
  for_each = toset(var.availability_zones)  # Crea una subnet por cada zona de disponibilidad
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, index(tolist(var.availability_zones), each.key))  # Usa un índice numérico basado en la lista de availability_zones
  map_public_ip_on_launch = true # Esto asigna IPs públicas automáticamente
  availability_zone       =  each.value #var.availability_zones # Usa each.value para la zona de disponibilidad

  tags = {
    Name = "${var.subnet_name}-${each.value}"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = var.route_table_name
  }
}

resource "aws_route_table_association" "private_association" {
  for_each = aws_subnet.private_subnet # Necesitamos for_each aquí para recorrer las subnets
  subnet_id      = each.value.id # Accede a cada subnet usando each.value.id
  route_table_id = aws_route_table.private_route_table.id
}
*/
# crear subnets publicas
resource "aws_subnet" "public_subnet" {
  for_each = toset(var.availability_zones) # Una subnet pública por cada zona de disponibilidad
  vpc_id   = aws_vpc.this.id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, index(tolist(var.availability_zones), each.key))
  map_public_ip_on_launch = true  # Esto asegura que las instancias reciban una IP pública
  availability_zone = each.value

  tags = {
    Name = "${var.vpc_name}-public-${each.value}"
  }
}

# Crear la ruta a Internet en la tabla de rutas
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.vpc_name}-public-rt"
  }
}

# Asociar subnets a las rutas publicas
resource "aws_route_table_association" "public_subnet_association" {
  for_each        = aws_subnet.public_subnet
  subnet_id       = each.value.id
  route_table_id  = aws_route_table.public_route_table.id
}

# Crear el Internet Gateway 
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}
