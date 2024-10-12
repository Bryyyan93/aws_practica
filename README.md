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

## Despliegue de la plantilla.
Para realizar el despliegue de la plantilla se ha hecho de manera modular, tambien se ha ido desarrollando paso a paso para verificar el funcionamiento de las partes por separado.  


### Crear VPC


