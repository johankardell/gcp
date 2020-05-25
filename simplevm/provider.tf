provider "google" {
  version     = 3.21
  credentials = file("~/.config/gcloud/application_default_credentials.json")
  project     = "neon-lock-277111"
  region      = "europe-north1"
}
