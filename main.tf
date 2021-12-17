provider "google" {
    credentials = "${file("${var.credentials}")}"
    project = "${var.gcp_project}"
    region = "${var.region}"
  
}
resource "google_compute_network" "vpc" {
    name = "${var.name}-vpc"
    auto_create_subnetworks = "false"
  
}
resource "google_compute_subnetworks" "subnet" {
    name = "${var.name}-subnet"
    ip_cidr_range = "${var.subnet_cidr}"
    network = "${var.name}-vpc"
    depends_on = ["google_compute_network.vpc"]
    region = "${var.region}"
}
resource "google_compute_firewall" "firewall" {
name  = "${var.name}-firewall"
network = "${google_compute_network.vpc.name}"
allow {
    protocol = "icmp"
}
allow{
    protocol = "tcp"
    ports = ["22"]
}
source_ranges =["0.0.0.0/0"]

}