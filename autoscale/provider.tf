provider "google" {
  version     = 3.21
  credentials = file("~/gcp/terraform.json")
  project     = "neon-lock-277111"
  region      = "europe-north1"
}
