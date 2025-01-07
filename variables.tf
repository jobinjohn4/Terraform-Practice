variable "region" {
  type = string

}

variable "ec2-main" {
  type = list(object({
    ami           = string
    instance_type = string
  }))

}


