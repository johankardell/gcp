locals {
  region = "europe-north1"
  zone   = "europe-north1-a"
}

resource "google_compute_autoscaler" "scaler" {
  name = "autoscaler"
  zone = local.zone

  target = google_compute_instance_group_manager.groupmanager.self_link

  autoscaling_policy {
    max_replicas    = 5
    min_replicas    = 1
    cooldown_period = 60

    cpu_utilization {
      target = 0.5
    }
  }
}

resource "google_compute_instance_template" "instance" {
  name           = "my-instance-template"
  machine_type   = "n1-standard-1"
  can_ip_forward = false
  tags           = ["web", "allow-lb-service"]

  disk {
    source_image = data.google_compute_image.centos_7.self_link
  }

  network_interface {
    network = "default"
  }
}

resource "google_compute_target_pool" "pool" {
  name = "my-target-pool"
}

resource "google_compute_instance_group_manager" "groupmanager" {
  name = "my-igm"
  zone = local.zone
  version {
    instance_template = google_compute_instance_template.instance.self_link
    name              = "primary"
  }

  target_pools       = [google_compute_target_pool.pool.self_link]
  base_instance_name = "terraform"
}

data "google_compute_image" "centos_7" {
  family  = "centos-7"
  project = "centos-cloud"
}

module "lb" {
  source       = "GoogleCloudPlatform/lb/google"
  version      = "2.2.0"
  region       = local.region
  name         = "load-balancer"
  service_port = 80
  target_tags  = ["my-target-pool"]
  network      = google_compute_network.vpctest.name
}
