# API Gateway + ECS Infrastructure

Este proyecto despliega una aplicación en ECS con API Gateway como punto de entrada y un Application Load Balancer.

## Componentes

- **API Gateway**: Punto de entrada público con endpoints:
  - POST /user/register
  - POST /user/login

- **Application Load Balancer**: Distribuye el tráfico a los contenedores

- **ECS Fargate**: Ejecuta los contenedores de la aplicación

- **VPC Link**: Conecta API Gateway con el ALB en la VPC privada

## Variables Requeridas

| Variable | Descripción | Ejemplo |
|----------|-------------|---------|
| `vpc_id` | ID de la VPC | `vpc-xxxxxxxx` |
| `ecr_repository_name` | Nombre del repositorio ECR (desde pre-infra) | `skillnest-dev-us-east-1-message-processor` |
| `dockerfile_path` | Ruta al Dockerfile | `../app/Dockerfile` |
| `app_source_path` | Ruta al código fuente | `../app` |

## Pre-requisitos

1. VPC configurada con:
   - Subnets públicas y privadas
   - NAT Gateway
   - Internet Gateway

2. Repositorio ECR creado (desde pre-infra)

3. Dockerfile y código de la aplicación

## Configuración del State

1. El bucket debe existir (creado previamente):
```bash
# En environments/dev/backend.tfvars
bucket         = "skillnest-terraform-states"
key            = "api-ecs/dev/terraform.tfstate"
region         = "us-east-1"
dynamodb_table = "terraform-locks"
encrypt        = true
```

## Despliegue

1. Construir y subir la imagen Docker:
```bash
# La imagen se construirá y subirá automáticamente durante el apply
```

2. Inicializar Terraform:
```bash
terraform init -backend-config=environments/dev/backend.tfvars
```

3. Seleccionar workspace:
```bash
terraform workspace new dev
terraform workspace select dev
```

4. Planear y aplicar cambios:
```bash
terraform plan -var-file=environments/dev/terraform.tfvars
terraform apply -var-file=environments/dev/terraform.tfvars
```

## Endpoints Disponibles

Después del despliegue, los endpoints estarán disponibles en:
```
https://<api-id>.execute-api.<region>.amazonaws.com/
```

Rutas:
- POST /user/register
- POST /user/login

## Limpieza

Para eliminar toda la infraestructura:
```bash
terraform destroy -var-file=environments/dev/terraform.tfvars
```

## Notas Importantes

1. La imagen Docker se construye y sube automáticamente cuando:
   - El Dockerfile cambia
   - El código fuente cambia
   - Se modifica el tag de la imagen

2. El API Gateway está configurado con CORS habilitado

3. Los logs están disponibles en CloudWatch:
   - /aws/apigateway/[nombre-api]
   - /ecs/[nombre-servicio]
