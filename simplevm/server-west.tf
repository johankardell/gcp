resource "google_compute_instance" "west1" {
  name         = "vm-west1"
  machine_type = "n1-standard-1"
  zone         = "europe-west1-d"

  tags = ["web"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network    = google_compute_network.vpctest.name
    subnetwork = google_compute_subnetwork.subnet1.name
    access_config {
      // Ephemeral IP
    }
  }

  metadata_startup_script = file("scripts/startupCentOSWeb.sh")
}

resource "google_compute_instance" "west2" {
  name         = "vm-west2"
  machine_type = "n1-standard-1"
  zone         = "europe-west1-d"

  tags = ["web"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network    = google_compute_network.vpctest.name
    subnetwork = google_compute_subnetwork.subnet1.name
    access_config {
      // Ephemeral IP
    }
  }

  metadata_startup_script = file("scripts/startupCentOSWorker.sh")
}
