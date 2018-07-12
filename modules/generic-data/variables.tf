variable "environment-profile-mapping" {
  type = "map"

  default = {
    "corp" = "ring-it"
    "dev"  = "dev-ring"
    "qa"   = "qa-ring"
    "prod" = "prod-ring"
  }
}

variable "environment-region-mapping" {
  type = "map"

  default = {
    "corp" = "us-east-1"
    "dev"  = "us-east-1"
    "qa"   = "us-east-1"
    "prod" = "us-east-1"
  }
}

variable "environment-account-mapping" {
  type = "map"

  default = {
    "corp" = "774154506888"
    "dev"  = "630825982732"
    "qa"   = "qa-ring"
    "prod" = "prod-ring"
  }
}

variable "environment-vpc-id-mapping" {
  type = "map"

  default = {
    "dev" = "vpc-fbd2f49e"
  }
}

variable "vpc-id-cidr-base-mapping" {
  type = "map"

  default = {
    "vpc-fbd2f49e" = "172.30"
  }
}

variable "environment-short-to-long-name-mapping" {
  type = "map"

  default = {
    "corp" = "corporate"
    "dev"  = "development"
    "qa"   = "qa"
    "prod" = "production"
  }
}

variable "region-elb-account-mapping" {
  type = "map"

  default = {
    "us-east-1"      = "127311923021"
    "us-east-2"      = "033677994240"
    "us-west-1"      = "027434742980"
    "us-west-2"      = "797873946194"
    "ca-central-1"   = "985666609251"
    "eu-central-1"   = "054676820928"
    "eu-west-1"      = "156460612806"
    "eu-west-2"      = "652711504416"
    "eu-west-3"      = "009996457667"
    "ap-northeast-1" = "582318560864"
    "ap-northeast-2" = "600734575887"
    "ap-northeast-3" = "383597477331"
    "ap-southeast-1" = "114774131450"
    "ap-southeast-2" = "783225319266"
    "ap-south-1"     = "718504428378"
    "sa-east-1"      = "507241528517"
  }
}

variable "elb-logs-bucket" {
  default = "ring-it-elb-logs"
}

variable "region-az-count-mapping" {
  type = "map"

  default = {
    "us-west-1"    = 3
    "us-west-2"    = 3
    "us-east-1"    = 6
    "us-east-2"    = 3
    "eu-west-1"    = 3
    "eu-west-2"    = 3
    "eu-central-1" = 3
  }
}

variable "number-to-letter-mapping" {
  type = "map"

  default = {
    "0" = "a"
    "1" = "b"
    "2" = "c"
    "3" = "d"
    "4" = "e"
    "5" = "f"
  }
}

variable "env-to-ssl-cert-arn" {
  type = "map"

  default = {
    "dev" = "arn:aws:acm:us-east-1:613225557329:certificate/863ed1ff-7e30-4853-87d5-01d3c24a0964"
  }
}
