output "tomoscan_ip" {
  value = "${module.tomoscan.loadbalancer_ip}"
}

output "tomomaster_ip" {
  value = "${module.tomomaster.loadbalancer_ip}"
}
