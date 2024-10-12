# Práctica Final de AWS - Bootcamp Keepcoding AWS
## Requisitos
Hacer una plantilla de Terraform que despliegüe:
- un **nginx** en un **Cluster ECS**. 
- Generar un output de Terraform con el endpoint de conexión.

### Parámetros de Entrega:

- Se entrega al final del módulo de AWS.
- Se debe entregar la plantilla Terraform para ser ejecutada por el Intructor a fín de evaluar la práctica final.
- La entrega es a través del GitHub del alumno.
- Al finalizar el tiempo de entrega, se facilitará la solución de la práctica final.

**Tips:** Se debe crear antes el **Task Definition** y para facilitar la práctica se hace en la **VPC Defaulft Pública**.  

https://medium.com/@vladkens/aws-ecs-cluster-on-ec2-with-terraform-2023-fdb9f6b7db07  

## Despliegue de la plantilla.
Para realizar el despliegue de la plantilla se ha hecho de manera modular, tambien se ha ido desarrollando paso a paso para verificar el funcionamiento de las partes por separado.  
El esquema general del despliegue es el siguiente:  
```
AWS_PRACTICA/
│
├── modules/               # Directorio que contiene módulos reutilizables.
│   ├── alb/               # Módulo para configurar el Application Load Balancer (ALB).
│   ├── autoscaling/       # Módulo para configurar el Auto Scaling Group (ASG).
│   ├── ecs_cluster/       # Módulo para configurar el clúster ECS.
│   ├── iam/               # Módulo para manejar los roles IAM.
│   ├── security_group/    # Módulo para gestionar los grupos de seguridad.
│   └── vpc/               # Módulo para la configuración de la VPC.
│
├── .gitignore             # Archivo para excluir ciertos archivos del control de versiones.
├── data.tf                # Definiciones de datos (como AMIs, VPCs existentes, etc.).
├── main.tf                # Archivo principal donde se invocan los módulos y recursos.
├── outputs.tf             # Archivo de salidas que exporta valores clave (ARNs, IDs, etc.).
├── README.md              # Documentación del despliegue.
└── variables.tf           # Definiciones de variables globales para el despliegue.

```  
Cada modulo tiene su configuración que se hará estandar para todos los modulos:  
```
modules/
│
└── alb/                   # Módulo para configurar el Application Load Balancer (ALB).
    ├── main.tf            # Archivo principal que define los recursos del ALB.
    ├── outputs.tf         # Archivo que exporta los valores clave del ALB (ARN, DNS, etc.).
    └── variables.tf       # Archivo donde se definen las variables utilizadas en este módulo.
```

### Crear VPC
Se crea los diferentes componentes en la ruta: `modules/vpc`  
Se crean una nueva VPC y dos subnets públicas  
```
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

... para la segunda es igual
```  
#### Crear un Internet Gateway
Permitirá el tráfico de entrada y salida de la VPC hacia internet.  
```
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  # Etiqueta para identificar el gateway
  tags = {
    Name = var.gateway_name
  }
}
```  
#### Crear una tabla de rutas pública para la VPC
```
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
```  
Y finalmente hay que asociar la subnet a la tabla de rutas  
```
resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_rt.id
}
```
Esto debe ser para las dos subnets, para la segunda es similar.

Una vez se ha creado este modulo, se puede comprobar que funciona. Para ello ejecutaremos el siguiente comando `terraform apply` y comprobamos que se ha creado correctamente:  
![Comprobar la correcta ejecución](./img/vpc_creation.png)  

### Crear un Cluster ECS escalable


