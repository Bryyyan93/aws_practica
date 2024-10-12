# Crea una VPC con el bloque CIDR especificado
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  # Identificar la VPC
  tags = {
    Name = var.vpc_name
  }
}

# Crea la primera subnet pública dentro de la VPC
resource "aws_subnet" "public_subnet_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_a_cidr # Bloque CIDR específico de la subnet
  map_public_ip_on_launch = true # Asigna una IP pública automáticamente al lanzar instancias
  availability_zone       = var.availability_zone_a # Zona de disponibilidad donde se creará la subnet

  # Identificar la subnet a
  tags = {
    Name = var.public_subnet_a_name
  }
}

# Crea la segunda subnet pública dentro de la VPC
resource "aws_subnet" "public_subnet_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_b_cidr
  map_public_ip_on_launch = true 
  availability_zone       = var.availability_zone_b 

  # Identificar la subnet b
  tags = {
    Name = var.public_subnet_b_name
  }
}

# Crea un Internet Gateway (IGW) que permitirá el tráfico de entrada y salida de la VPC hacia internet.
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  # Etiqueta para identificar el gateway
  tags = {
    Name = var.gateway_name
  }
}

# Crea una tabla de rutas pública para la VPC
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  # Define una ruta que envía todo el tráfico (0.0.0.0/0) hacia el Internet Gateway
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  # Etiqueta para identificar la tabla de rutas
  tags = {
    Name = var.route_table_name
  }
}

# Asocia la subnet pública A con la tabla de rutas pública
resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_rt.id
}

# Asocia la subnet pública B con la tabla de rutas pública
resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.public_rt.id
}
