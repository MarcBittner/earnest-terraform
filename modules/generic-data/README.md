
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| elb-logs-bucket |  | string | `ring-it-elb-logs` | no |
| env-to-consul-mapping |  | string | `<map>` | no |
| env-to-dns-hosted-zone-mapping |  | map | `<map>` | no |
| env-to-dns-suffix-mapping |  | map | `<map>` | no |
| env-to-jumpbox-security-group-mapping |  | string | `<map>` | no |
| env-to-logs-bucket-arn-mapping |  | string | `<map>` | no |
| env-to-ssl-cert-arn-mapping | ssl certificate arn for internal network that is *.ring.net | map | `<map>` | no |
| environment-account-id-mapping |  | map | `<map>` | no |
| environment-account-mapping |  | map | `<map>` | no |
| environment-profile-mapping |  | map | `<map>` | no |
| environment-region-mapping |  | map | `<map>` | no |
| environment-short-to-long-name-mapping |  | map | `<map>` | no |
| environment-vpc-id-mapping |  | map | `<map>` | no |
| number-to-letter-mapping |  | map | `<map>` | no |
| region-az-count-mapping |  | map | `<map>` | no |
| region-elb-account-mapping |  | map | `<map>` | no |
| vpc-id-cidr-base-mapping |  | map | `<map>` | no |
| vpc-id-to-internet-gateway-id-mapping |  | map | `<map>` | no |
| vpc-id-to-security-group-mapping |  | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| elb-logs-bucket |  |
| env |  |
| env-to-consul-mapping |  |
| env-to-dns-hosted-zone-mapping |  |
| env-to-dns-suffix-mapping |  |
| env-to-jumpbox-security-group-mapping |  |
| env-to-logs-bucket-arn-mapping |  |
| env-to-ssl-cert-arn-mapping |  |
| environment-account-id-mapping |  |
| environment-account-mapping |  |
| environment-profile-mapping |  |
| environment-region-mapping |  |
| environment-short-to-long-name-mapping |  |
| environment-vpc-id-mapping |  |
| number-to-letter-mapping |  |
| region |  |
| region-az-count-mapping |  |
| region-elb-account-mapping |  |
| vpc-id-cidr-base-mapping |  |
| vpc-id-to-internet-gateway-id-mapping |  |
| vpc-id-to-security-group-mapping |  |

