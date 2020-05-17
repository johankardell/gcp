resource "google_compute_instance" "north1" {
  name         = "vm-north1"
  machine_type = "n1-standard-1"
  zone         = "europe-north1-a"

  tags = ["web", "ping"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network    = google_compute_network.vpctest.name
    subnetwork = google_compute_subnetwork.subnet0.name
    access_config {
      // Ephemeral IP
    }
  }
  
  metadata_startup_script = file("scripts/startupUbuntuWeb.sh")
}


resource "google_compute_instance" "north2" {
  name         = "vm-north2"
  machine_type = "n1-standard-1"
  zone         = "europe-north1-a"

  tags = ["worker", "ping"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network    = google_compute_network.vpctest.name
    subnetwork = google_compute_subnetwork.subnet0.name
    access_config {
      // Ephemeral IP
    }
  }
  
  metadata_startup_script = file("scripts/startupUbuntuWorker.sh")
}
