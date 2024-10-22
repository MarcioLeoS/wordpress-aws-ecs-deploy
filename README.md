Despliegue de WordPress en AWS ECS
Este documento describe el flujo de trabajo para desplegar una aplicación de WordPress en AWS Elastic Container Service (ECS) utilizando GitHub Actions.

Descripción General del Flujo de Trabajo
Este flujo de trabajo de GitHub Actions automatiza el despliegue de una aplicación de WordPress cada vez que se realiza un push al branch main. Realiza varias tareas, incluyendo la construcción de una imagen Docker, su carga en Amazon Elastic Container Registry (ECR), la creación de un clúster ECS, la configuración de redes, el establecimiento de una base de datos y la gestión de grupos de seguridad.

Activador del Flujo de Trabajo
El flujo de trabajo se activa con eventos push en el branch main.


Variables de Entorno
Se utilizan las siguientes variables de entorno a lo largo del flujo de trabajo:

AWS_REGION: La región de AWS para el despliegue (por defecto: us-east-2).
ECR_REPOSITORY_NAME: El nombre del repositorio ECR (por defecto: wordpress-repository).
ECS_CLUSTER_NAME: El nombre del clúster ECS (por defecto: wordpress-cluster).
ECS_SERVICE_NAME: El nombre del servicio ECS (por defecto: wordpress-service).
CONTAINER_NAME: El nombre del contenedor (por defecto: wordpress).
IMAGE_TAG: La etiqueta de la imagen Docker (por defecto: latest).
DB_INSTANCE_IDENTIFIER: El identificador para la instancia de la base de datos RDS (por defecto: wordpress-db).
DB_USERNAME: El nombre de usuario para la base de datos (por defecto: wordpressuser).
DB_PASSWORD: La contraseña para la base de datos (por defecto: wordpresspassword).
DB_NAME: El nombre de la base de datos (por defecto: wordpressdb).

Pasos del Flujo de Trabajo

1. Obtener el Código
El flujo de trabajo comienza obteniendo el código del repositorio.

3. Configurar Credenciales de AWS
Se configuran las credenciales de AWS utilizando secretos de GitHub (AWS_ACCESS_KEY_ID y AWS_SECRET_ACCESS_KEY).

5. Construir la Imagen Docker
Se construye una imagen Docker para WordPress utilizando el Dockerfile proporcionado.

7. Iniciar Sesión en Amazon ECR
El flujo de trabajo inicia sesión en el registro de Amazon ECR para prepararse para cargar la imagen Docker.

9. Crear Repositorio ECR
Se verifica si el repositorio ECR existe; si no, se crea uno nuevo.

11. Etiquetar y Cargar la Imagen Docker en ECR
La imagen Docker se etiqueta y se carga en el repositorio ECR.

13. Crear Clúster ECS
Se verifica si el clúster ECS existe y se crea uno si no lo tiene.

15. Crear VPC y Subredes
Se crea una Red Privada Virtual (VPC) y subredes públicas/privadas si no existen ya.

17. Crear Grupos de Seguridad
Se crean o actualizan los grupos de seguridad para ECS y RDS con las reglas de entrada necesarias.

19. Crear Base de Datos RDS
Se crea una instancia de base de datos RDS si no existe, y se almacena el punto de enlace para su uso posterior.

21. Crear Sistema de Archivos EFS
Se crea un sistema de archivos de Amazon EFS para almacenamiento persistente, con puntos de montaje creados en las subredes privadas.

23. Registrar Definición de Tarea
Se registra una definición de tarea para el servicio ECS utilizando el archivo de configuración renderizado.

25. Crear o Actualizar Servicio ECS
Finalmente, se crea o actualiza el servicio ECS según la definición de tarea y la configuración de red.

Configuración de Secretos
configurar los siguientes secretos en el repositorio de GitHub:

AWS_ACCESS_KEY_ID: Tu ID de clave de acceso de AWS.
AWS_SECRET_ACCESS_KEY: Tu clave de acceso secreta de AWS.

Requisitos Previos

Cuenta de AWS con permisos para gestionar recursos de ECS, ECR, RDS y VPC.
