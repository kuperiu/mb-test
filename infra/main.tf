data "google_project" "project" {}

resource "google_project_service" "project" {
    project = "${data.google_project.project.id}"
  service = "container.googleapis.com"
  disable_dependent_services = true

}

resource "google_container_cluster" "primary" {
  name               = "${data.google_project.project.id}"
  location           = "us-central1-a"
  initial_node_count = 2
}