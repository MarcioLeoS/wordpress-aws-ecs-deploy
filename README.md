WordPress Deployment on AWS ECS

This document describes the workflow to deploy a WordPress application on AWS Elastic Container Service (ECS) using GitHub Actions.

Workflow Overview
This GitHub Actions workflow automates the deployment of a WordPress application whenever a push is made to the main branch. It performs several tasks, including building a Docker image, uploading it to Amazon Elastic Container Registry (ECR), creating an ECS cluster, configuring networking, setting up a database, and managing security groups.

Workflow Trigger
The workflow is triggered by push events to the main branch.

Environment Variables
The following environment variables are used throughout the workflow:

AWS_REGION: The AWS region for deployment (default: us-east-2).
ECR_REPOSITORY_NAME: The name of the ECR repository (default: wordpress-repository).
ECS_CLUSTER_NAME: The name of the ECS cluster (default: wordpress-cluster).
ECS_SERVICE_NAME: The name of the ECS service (default: wordpress-service).
CONTAINER_NAME: The name of the container (default: wordpress).
IMAGE_TAG: The Docker image tag (default: latest).
DB_INSTANCE_IDENTIFIER: The identifier for the RDS database instance (default: wordpress-db).
DB_USERNAME: The database username (default: wordpressuser).
DB_PASSWORD: The database password (default: wordpresspassword).
DB_NAME: The database name (default: wordpressdb).
Workflow Steps
Fetch Code
The workflow begins by fetching the code from the repository.

Set Up AWS Credentials
AWS credentials are set up using GitHub secrets (AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY).

Build Docker Image
A Docker image for WordPress is built using the provided Dockerfile.

Log in to Amazon ECR
The workflow logs into the Amazon ECR registry to prepare for uploading the Docker image.

Create ECR Repository
The workflow checks if the ECR repository exists; if not, a new one is created.

Tag and Push Docker Image to ECR
The Docker image is tagged and pushed to the ECR repository.

Create ECS Cluster
The workflow checks if the ECS cluster exists and creates one if necessary.

Create VPC and Subnets
A Virtual Private Cloud (VPC) and public/private subnets are created if they don't already exist.

Create Security Groups
Security groups for ECS and RDS are created or updated with necessary inbound rules.

Create RDS Database
An RDS database instance is created if it doesn’t already exist, and the endpoint is stored for later use.

Create EFS File System
An Amazon EFS file system is created for persistent storage, with mount points in the private subnets.

Register Task Definition
A task definition for the ECS service is registered using the rendered configuration file.

Create or Update ECS Service
Finally, the ECS service is created or updated according to the task definition and network configuration.

Secret Configuration
Configure the following secrets in the GitHub repository:

AWS_ACCESS_KEY_ID: Your AWS access key ID.
AWS_SECRET_ACCESS_KEY: Your AWS secret access key.
Prerequisites
An AWS account with permissions to manage ECS, ECR, RDS, and VPC resources.