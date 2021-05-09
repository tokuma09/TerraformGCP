variable "project" {
}

variable "credentials_file" {
}

variable "GITHUB_PAT" {

}

variable "NEPTUNE_API_TOKEN" {

}
variable "region" {
  type    = string
  default = "asia-northeast1"
}

variable "zone" {
  default = "asia-northeast1-c"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "machine_types" {
  type = map(any)
  default = {
    dev  = "f1-micro"
    prod = "e2-standard-4"
  }
}
