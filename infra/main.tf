module "ecs" {
  source = "../../modules/ecs"

  name = local.name

  # Capacity provider
  default_capacity_provider_strategy = {
    FARGATE = {
      weight = 50
      base   = 20
    }
    FARGATE_SPOT = {
      weight = 50
    }
  }

  tags = local.tags
}
