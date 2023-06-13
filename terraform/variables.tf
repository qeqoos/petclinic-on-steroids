variable "APP_NAME" {
  default = "placeholder"
  type    = string
}

variable "CLUSTER_NAME" {
  default = "ubercluster"
  type    = string
}

variable "DB_PASSWORD" {
  type      = string
  sensitive = true
}