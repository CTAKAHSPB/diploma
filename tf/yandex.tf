terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

// Configure the Yandex.Cloud provider
provider "yandex" {
  token                    = var.token
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = "ru-central1-a"
}

// Create a new instance
resource "yandex_compute_instance" "master_host" {

  name = "master"
  platform_id = "standard-v1" # тип процессора (Intel Broadwell)

  boot_disk {
    initialize_params {
	  image_id = "fd8g6ua52uh4buk199of" # Debian 12
    }
  }
  network_interface {
    subnet_id = var.subnet_id
    nat = true
  }
  resources {
    cores = 4
    memory = 8
  }
  metadata = {
	user-data = "${file("./userinfo")}"
  }
}

resource "yandex_compute_instance" "worker_host" {

  name = "worker"
  platform_id = "standard-v1" # тип процессора (Intel Broadwell)

  boot_disk {
    initialize_params {
	  image_id = "fd8g6ua52uh4buk199of" # Debian 12
    }
  }
  network_interface {
    subnet_id = var.subnet_id
    nat = true
  }
  resources {
    cores = 4
    memory = 8
  }
  metadata = {
	user-data = "${file("./userinfo")}"
  }
}

resource "yandex_compute_instance" "srv_host" {

  name = "srv"
  platform_id = "standard-v1" # тип процессора (Intel Broadwell)

  boot_disk {
    initialize_params {
	  image_id = "fd8g6ua52uh4buk199of" # Debian 12
    }
  }
  network_interface {
    subnet_id = var.subnet_id
    nat = true
  }
  resources {
    cores = 2
    memory = 2
  }
  metadata = {
	user-data = "${file("./userinfo")}"
  }
}

resource "yandex_lb_target_group" "foo" {
  name      = "my-target-group"
  region_id = "ru-central1"

  target {
    subnet_id = var.subnet_id
    address   = "${yandex_compute_instance.master_host.network_interface.0.ip_address}"
  }

  target {
    subnet_id = var.subnet_id
    address   = "${yandex_compute_instance.worker_host.network_interface.0.ip_address}"
  }

  target {
    subnet_id = var.subnet_id
    address   = "${yandex_compute_instance.srv_host.network_interface.0.ip_address}"
  }
}

output "master_ip" {
    value = yandex_compute_instance.master_host.network_interface[0].nat_ip_address
}

output "worker_ip" {
    value = yandex_compute_instance.worker_host.network_interface[0].nat_ip_address
}

output "srv_ip" {
    value = yandex_compute_instance.srv_host.network_interface[0].nat_ip_address
}

