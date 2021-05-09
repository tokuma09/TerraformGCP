
// terraformブロックがどのプロバイダーをterraformブロックからとってくるかを定める
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}


// providerブロックにその後のリソースを作成したりするために使う情報が含まれる
provider "google" {

  credentials = file(var.credentials_file)

  project = var.project
  region  = var.region
  zone    = var.zone
}

// resourceブロック: インフラ内のリソースを定義する
// 最初の引数がリソースタイプ, 2つめが名前
// google_とつけているから、これでgoogle providerが処理するものと分かる
# resorceのidはタイプと名前をくみあわせている


resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

# We create a public IP address for our google compute instance to utilize
resource "google_compute_address" "static" {
  name = "ipv4-address"
}

// GCE
resource "google_compute_instance" "vm_instance" {
  // インスタンスの名前
  name = "terraform-instance"


  // GCEのインスタンスタイプ設定
  machine_type = var.machine_types[var.environment]
  // イメージ
  boot_disk {
    initialize_params {
      # osのイメージを設定

      image = "ubuntu-os-cloud/ubuntu-1804-lts"
      # google container-optimized osだが,vscodeのremote-sshでは使えなかった
      # ボリュームサイズ
      size = 10
      type = "pd-standard" # 標準

    }
  }
  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }

  metadata = {
    "GITHUB_PAT"                     = var.GITHUB_PAT
    "NEPTUNE_API_TOKEN"              = var.NEPTUNE_API_TOKEN
    "GOOGLE_APPLICATION_CREDENTIALS" = file(var.credentials_file)
  }
  metadata_startup_script = file("./scripts/bootstrap.sh")

}
