resource "google_compute_network" "vpctest" {
  name = "vpctest"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet0" { 
  description = "Northern subnet"
  name = "subnet-0"
  region = "europe-north1"
  ip_cidr_range = "192.168.0.0/24"
  network = google_compute_network.vpctest.name
}

resource "google_compute_subnetwork" "subnet1" { 
  description = "Western subnet"
  name = "subnet-1"
  region = "europe-west1"
  ip_cidr_range = "192.168.1.0/24"
  network = google_compute_network.vpctest.name
}