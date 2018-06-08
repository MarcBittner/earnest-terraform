variable "environment-cidr-mapping" {
  type = "map"
 
  default {
    "corp-us-east-1" = "10.90"
    "dev-us-east-1" = "10.91"
    "qa-us-east-1" = "10.92"
    "stage-us-east-1" = "10.93"
    "prod-us-east-1" = "10.94"
  }
}
