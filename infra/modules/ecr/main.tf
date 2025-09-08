resource "aws_ecr_repository" "urlapp" {
  name                 = var.repo_name
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  
}


resource "aws_ecr_lifecycle_policy" "parameters" {
  repository = aws_ecr_repository.urlapp.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep last X images (any tags)"
        selection = {
          tagStatus     = "any"
          countType     = "imageCountMoreThan"
          countNumber   = var.keep_last_images
        }
        action = {
          type = "expire"
        }
      },
      {
        rulePriority = 2
        description  = "Expire untagged images older than X days"
        selection = {
          tagStatus   = "untagged"
          countType   = "sinceImagePushed"
          countUnit   = "days"
          countNumber = var.untagged_expiration_days
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}