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

variable "environment-account-id-mapping" {
  type = "map"

  default = {
    "dev"  = "613225557329"
    "qa"   = "613225557329"
    "prod" = ""
  }
}

variable "environment-account-mapping" {
  type = "map"

  default = {
    "corp" = "774154506888"
    "dev"  = "630825982732"
    "qa"   = "qa-ring"
    "prod" = "doorbot"
  }
}

variable "environment-vpc-id-mapping" {
  type = "map"

  default = {
    "dev"  = "vpc-fbd2f49e"
    "qa"   = "vpc-adf7b0cb"
    "prod" = "vpc-65835100"
  }
}

variable "vpc-id-cidr-base-mapping" {
  type = "map"

  default = {
    "vpc-fbd2f49e" = "172.30"
    "vpc-adf7b0cb" = "10.3"
    "vpc-65835100" = "172.16"
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

variable "env-to-ssl-cert-arn-mapping" {
  type = "map"

  default = {
    "dev"  = "arn:aws:acm:us-east-1:613225557329:certificate/50214436-8d1c-4fc4-b5cd-276913e5124b"
    "qa"   = "arn:aws:acm:us-east-1:613225557329:certificate/3be6741a-1f68-4e82-9a28-9be01cfba88f"
    "prod" = "arn:aws:acm:us-east-1:890452240102:certificate/e802ee17-8ba2-4913-a304-a6a1e563cbc2"
  }
}

variable "env-to-dns-suffix-mapping" {
  type = "map"

  default = {
    "dev"  = "dev.ring.net."
    "qa"   = "qa.ring.net."
    "prod" = "prod.ring.net."
  }
}

variable "env-to-dns-hosted-zone-mapping" {
  type = "map"

  default = {
    "dev"  = "Z3E5ZY2M39OYQR"
    "qa"   = "Z1UFFBKG22RQQ8"
    "prod" = "Z3H7ZFJEXP3Q4H"
  }
}

variable "vpc-id-to-internet-gateway-id-mapping" {
  type = "map"

  default = {
    "vpc-fbd2f49e" = "igw-75127610" # Dev
    "vpc-adf7b0cb" = "igw-6c744e0b" # QA
    "vpc-65835100" = "igw-ccec12a9" # Prod
  }
}

variable "vpc-id-to-security-group-mapping" {
  type = "map"

  default = {
    "vpc-fbd2f49e" = "sg-e61d2d82" # Dev
    "vpc-adf7b0cb" = "sg-21e33a5e" # QA
    "vpc-65835100" = "sg-329eda57" # Prod
  }
}

variable "env-to-consul-mapping" {
  "type" = "map"

  default = {
    "dev"  = "consul.dev.ring.com:8500"
    "qa"   = "consul.qa.ring.com:8500"
    "prod" = "consul.ring.com:8500"
  }
}

variable "env-to-jumpbox-security-group-mapping" {
  "type" = "map"

  default = {
    "dev"  = "sg-d17af2a6"
    "qa"   = "sg-540c8423"
    "prod" = "sg-7b4cc40c"
  }
}

variable "env-to-logs-bucket-arn-mapping" {
  "type" = "map"

  default = {
    "dev"  = "arn:aws:s3:::ring-data-lake-dev"
    "qa"   = "arn:aws:s3:::ring-data-lake-qa"
    "prod" = "arn:aws:s3:::ring-data-lake"
  }
}
