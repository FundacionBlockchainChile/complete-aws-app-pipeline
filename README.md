# Complete AWS App Pipeline

Este proyecto es una plantilla para desplegar una aplicación web completa en AWS utilizando las mejores prácticas de DevOps. Incluye un frontend en React, un backend en Node.js, y una infraestructura completa gestionada con Terraform.

## Arquitectura

- **Frontend**: React.js con TypeScript
- **Backend**: Node.js con Express y TypeScript
- **Base de Datos**: PostgreSQL en Amazon RDS
- **Infraestructura**: 
  - ECS Fargate para contenedores
  - RDS para base de datos
  - Application Load Balancer
  - VPC con subredes públicas y privadas
  - ECR para registro de contenedores
  - S3 y DynamoDB para estado de Terraform

## Requisitos Previos

1. Cuenta de AWS
2. AWS CLI instalado y configurado
3. Terraform instalado
4. Node.js y npm instalados
5. Docker instalado
6. GitHub Account

## Configuración Inicial

1. **Fork y Clonar el Repositorio**
   ```bash
   git clone https://github.com/your-username/complete-aws-app-pipeline.git
   cd complete-aws-app-pipeline
   ```

2. **Configurar Variables de Entorno**
   - Copiar los archivos de ejemplo:
     ```bash
     cp src/frontend/.env.example src/frontend/.env
     cp src/backend/.env.example src/backend/.env
     ```
   - Actualizar las variables según tu entorno

3. **Configurar Secretos de GitHub**
   En tu repositorio de GitHub, ve a Settings > Secrets and variables > Actions y añade:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`
   - `AWS_ACCOUNT_ID`

4. **Inicializar Backend de Terraform**
   ```bash
   cd terraform
   terraform init
   ```

## Desarrollo Local

1. **Backend**
   ```bash
   cd src/backend
   npm install
   npm run dev
   ```

2. **Frontend**
   ```bash
   cd src/frontend
   npm install
   npm start
   ```

## Despliegue

El pipeline de CI/CD se activará automáticamente con cada push a la rama main. El proceso incluye:

1. Pruebas
2. Construcción de imágenes Docker
3. Push a ECR
4. Despliegue en ECS
5. Actualización de infraestructura con Terraform

## Estructura del Proyecto

```
.
├── .github/workflows/    # Pipeline de CI/CD
├── infrastructure/       # Scripts de infraestructura
├── src/
│   ├── backend/         # API Node.js
│   └── frontend/        # App React
└── terraform/           # Configuración de Terraform
```

## Variables de Entorno Requeridas

### Frontend
- `REACT_APP_API_URL`: URL del backend

### Backend
- `PORT`: Puerto del servidor
- `DB_HOST`: Host de la base de datos
- `DB_PORT`: Puerto de la base de datos
- `DB_NAME`: Nombre de la base de datos
- `DB_USER`: Usuario de la base de datos
- `DB_PASSWORD`: Contraseña de la base de datos

## Limpieza de Recursos

Para eliminar todos los recursos creados:

```bash
cd terraform
terraform destroy -var-file="environments/dev.tfvars"
```

## Contribuir

1. Fork el repositorio
2. Crea una rama para tu feature
3. Commit tus cambios
4. Push a la rama
5. Crea un Pull Request

## Licencia

MIT

## Notas de Seguridad

- Nunca comitees archivos .env o credenciales
- Usa siempre secretos de GitHub para información sensible
- Revisa regularmente las políticas de IAM
- Mantén las dependencias actualizadas
