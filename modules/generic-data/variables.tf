variable "environment-profile-mapping" {
  type = "map"

  default = {
    "dev"  = "ring-dev"
    "prod" = "ring-prod"
  }
}

variable "environment-region-mapping" {
  type = "map"

  default = {
    "dev"  = "us-east-1"
    "qa"   = "us-east-1"
    "prod" = "us-east-1"
  }
}

variable "short-to-long-name-mapping" {
  type = "map"

  default = {
    "dev"  = "development"
    "qa"   = "qa"
    "prod" = "production"
  }
}
