variable "aws_user_data" {
  type = "map"

  default = {
    dev-us-east-1  = ""
    prod-us-east-1 = ""
    corp-us-east-1 = "d6393eb9289b8fc337fab5f41f256aa9/d9335429ae4a836f03e0f5ac3470c1e7dd83a8b16c6a9f4fa9aac561f32f93f032b6cf179d54a8bcff72aaef5bcb89b999366722bf8144d379ef6ad16d2d628d/885007a6067f3cf58f642b68f8ec627f342565d41ed69dd53cad73d1558bfef3"
  }
}
