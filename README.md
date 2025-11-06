
# ECS Fargate Project - URL Shortener

A URL shortener application containerised and deployed onto AWS ECS Fargate using Terraform and Github Actions. The service sits behind an Application Load Balancer with WAF rules configured for protection and blue/green deployments enabled via CodeDeploy in order to allow zero-downtime and rollback capabilities.


# Architectural Diagram

<img width="570" height="605" alt="Screenshot 2025-11-03 at 13 09 36" src="https://github.com/user-attachments/assets/bbf024fe-4b13-4e9b-9bc2-aa6fc51c3398" />

# Project Structure

```bash
├── README.md
├── .github/workflows    (CI/CD Github Actions Pipelines)
├── app                  ( Python FastAPI url shortener application)
└── infra                
    ├── global           (Contains Terraform state configuration)
    ├── modules          (Terraform Modules to provision AWS infrastructure)
    ├── main.tf
    ├── outputs.tf
    ├── providers.tf
    ├── terraform.tfvars
    └── variables.tf
```


# Key Infrastructure Features

- AWS ECS Fargate Cluster: A serverless, scalable compute option to host and run the application
- Application Load Balancer (ALB): Handles HTTPS termination and forwarding to ECS target groups
- AWS WAF: Protects ALB by filtering web requests. Uses AWS managed rulesets.
- CodeDeploy: Enables Blue/Green deployments and automatic rollback to allow zero-downtime feature releases
- VPC Endpoints: Cost-efficient option to provide private access to AWS resources.
- DynamoDB: Provides storage for url mappings
- Route53 + ACM: Allows service to use custom domain and issues TLS certificate for secure connections
- Github Actions: CI/CD pipelines to containerise application and deploy Terraform provisioned infrastructure. OIDC enabled.


<img width="1480" height="743" alt="image" src="https://github.com/user-attachments/assets/56ee075f-e16d-4329-b161-8b537d3b2c7c" />


<img width="2392" height="606" alt="image" src="https://github.com/user-attachments/assets/f71ccca2-f0cf-429a-a7c8-6db0ebddc7ce" />



# CI Pipeline

- Builds and containerises application according to instructions defined in Dockerfile.
- Uses Trivy to scan the image for any vulnerabilities
- Configures OIDC for AWS authentication via temporary credentials instead of using long-term stored access keys
- Logs into ECR and pushes successfully compiled images onto repository.

  <img width="1459" height="785" alt="image" src="https://github.com/user-attachments/assets/69985210-f9c1-49a8-a820-e85c9986987b" />


# CD Pipeline

- Authenticates to AWS via OIDC
- Initialises, plans, and applies Terraform infrastructure changes defined in modules and state file.
- Registers ECS Task definition and passes the task definition arn into the appspec.json file which instructs CodeDeploy
- Triggers a CodeDeploy ECS deployment to handle application updates. Automatic rollback is enabled in case of any failures during the deployment.

  <img width="2130" height="1502" alt="image" src="https://github.com/user-attachments/assets/b2820e85-85a4-4d88-b5ef-c781a33cac33" />

  <img width="2220" height="1228" alt="image" src="https://github.com/user-attachments/assets/4924a5b4-8f50-4b2d-936a-9b3eda780cd4" />

# Design Decisions/Rationale

- VPC Endpoints: More cost-efficient than NAT Gateways and allows architecture to remain in private subnets, reducing attack surface 
- CodeDeploy blue/green: Allows zero downtime deployment using blue/green strategy and automatic rollback.
- GitHub Actions OIDC: Uses temporary, scoped credentials which are generated during each workflow run and as a result enhances security posture
- Terraform modules: Allows for easy reuse and maintainance of cloud infrastructure as well as clean separation of concerns


# Screenshots

<img width="1751" height="252" alt="image" src="https://github.com/user-attachments/assets/634f47fc-835b-49d6-9c1e-d3a80c0ebaf1" />

<img width="1440" height="875" alt="image" src="https://github.com/user-attachments/assets/c08a9aad-20b7-4f5e-ae09-8957514af882" />


  
