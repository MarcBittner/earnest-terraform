variable "aws_user_data" {
  type = "map"

  default = {
    dev-us-east-1  = ""
    prod-us-east-1 = ""
    corp-us-east-1 = "264fedba3297f49bf0851e9efe1e8dbb/077be7241c397a3b481bc79aabb93f2ac58ed9021157b552e1738c3ac8b883dc07265ddc2c6c0ac0c49247937c999d33ff1f4ae96b6281fffaeb735c27487240/d21e15b4bff3e90bfec856c33e916083e98511ab8570c3a6ce632ba92e0faa13"
  }
}
