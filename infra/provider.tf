variable "project_name" {}


terraform {
  required_version = "= 0.11.10"
}

provider "google" {
  region  = "europe-west1"
  version = "2.5.1"
  project  = "${var.project_name}"
}