resource "google_compute_firewall" "web" {
  name    = "web-firewall"
  network = google_compute_network.vpctest.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web"]
}

resource "google_compute_firewall" "ssh" {
  name    = "ssh"
  network = google_compute_network.vpctest.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web", "worker"]
}
