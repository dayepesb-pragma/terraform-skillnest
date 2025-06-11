# Terraform Lambda Project

Este proyecto despliega una función Lambda con su cola SQS y roles IAM asociados.

## Variables Requeridas

| Variable | Descripción | Ejemplo |
|----------|-------------|---------|
| `environment` | Entorno de despliegue | `"dev"`, `"qa"`, `"prod"` |
| `project` | Nombre del proyecto | `"skillnest"` |
| `aws_region` | Región de AWS | `"us-east-1"` |
| `artifacts_bucket_name` | Nombre del bucket S3 (desde pre-infra) | `"skillnest-dev-artifacts"` |

## Configuración del State

1. El bucket ya debe existir (creado en pre-infra)

2. Crear el archivo de backend para dev:
```bash
# En terraform-lambda/environments/dev/backend.tfvars
bucket         = "skillnest-terraform-states"
key            = "lambda/dev/terraform.tfstate"
region         = "us-east-1"
dynamodb_table = "terraform-locks"
encrypt        = true
```

## Despliegue

1. Compilar el código TypeScript:
```bash
cd lambda
npm run build
npm run deploy
```

2. Inicializar Terraform con el backend:
```bash
cd ../terraform-lambda
terraform init -backend-config=environments/dev/backend.tfvars
```

3. Seleccionar el workspace:
```bash
terraform workspace new dev
terraform workspace select dev
```

4. Planear y aplicar cambios:
```bash
terraform plan -var-file=environments/dev/terraform.tfvars
terraform apply -var-file=environments/dev/terraform.tfvars
```
