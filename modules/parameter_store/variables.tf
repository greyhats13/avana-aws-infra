variable "region" {
  default = "ap-southeast-1"
}

variable "unit" {
  default = "avn"
}

variable "env" {
  default = "dev"
}

variable "code" {
  default = "ssm"
}

variable "feature" {
  default = "cloudflare"
}

variable "creator" {
  default = "tf"
}

variable "overwrite" {
  type = bool
  description = "overwrite SSM value changes"
}

variable "cloudflare" {
  type = map(string)
  description = "Cloudflare parameters"
}