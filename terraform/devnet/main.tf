terraform {
  backend "remote" {
    organization = "tomochain"

    workspaces {
      name = "devnet"
    }
  }
}

provider "digitalocean" {
  token = "${var.do_token}"
}

provider "kubernetes" {
  host = "${module.kubernetes.endpoint}"

  client_certificate     = "${module.kubernetes.client_certificate}"
  client_key             = "${module.kubernetes.client_key}"
  cluster_ca_certificate = "${module.kubernetes.cluster_ca_certificate}"
}

provider "helm" {
  service_account = "${module.kubernetes.service_account}"

  kubernetes {
    host = "${module.kubernetes.endpoint}"

    client_certificate     = "${module.kubernetes.client_certificate}"
    client_key             = "${module.kubernetes.client_key}"
    cluster_ca_certificate = "${module.kubernetes.cluster_ca_certificate}"
  }
}

module "kubernetes" {
  source = "../modules/providers/digitalocean/kubernetes"

  name = "devnet"
}

module "netdata" {
  source = "../modules/providers/helm/netdata"

  notifications_url       = "${var.notifications_url}"
  notifications_recipient = "netdata-devnet"
}

module "tomoscan" {
  source = "../modules/tomoscan"

  crawler_replicas = 6
}
