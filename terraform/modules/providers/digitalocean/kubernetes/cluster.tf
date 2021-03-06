resource "digitalocean_kubernetes_cluster" "cluster" {
  name    = "${var.name}"
  region  = "${var.region}"
  version = "1.13.3-do.0"

  node_pool {
    name       = "workers"
    size       = "s-6vcpu-16gb"
    node_count = 3
  }
}
