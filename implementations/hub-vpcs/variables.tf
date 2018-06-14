variable "environment-cidr-mapping" {
  type = "map"

  default {
    "corp-us-east-1"  = "10.90"
    "dev-us-east-1"   = "10.91"
    "qa-us-east-1"    = "10.92"
    "stage-us-east-1" = "10.93"
    "prod-us-east-1"  = "10.94"
  }
}

variable "external-allow-all-cidrs" {
  type = "map"

  default {
    "corp-us-east-1"  = ["172.16.0.0/16"]
    "dev-us-east-1"   = [] 
    "qa-us-east-1"    = [] 
    "stage-us-east-1" = [] 
    "prod-us-east-1"  = [] 
  }
}

