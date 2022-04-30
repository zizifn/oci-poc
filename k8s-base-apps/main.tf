terraform {

  #terraform cloud
  cloud {
    # 用来同步 terraform state 到cloud 上。
    organization = "zizifn"
    hostname     = "app.terraform.io" # Optional; defaults to app.terraform.io

    workspaces {
      name = "k8s-base-apps"
      # tags = ["networking", "source:cli"]
    }
  }

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.10.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.5.1"
    }
  }
}


provider "helm" {
  kubernetes {
    config_path = "../oci_kube_config.temp"
  }
  debug = true
}

provider "kubernetes" {
  config_path = "../oci_kube_config.temp"
}

module "k8s-auth-token" {
  source = "./modules/k8s-auth-token"
}


# get kubeconfig-sa secrets

resource "local_sensitive_file" "sa_kube_config" {
  count = var.local ? 1 : 0
  content = templatefile("${path.module}/sa_kube_config.tftpl",
    {
      host                     = ""
      config_context_auth_info = "kubeconfig-sa"
      token                    = module.k8s-auth-token.kubeconfig_sa_secret.data.token
      cluster_ca_certificate   = module.k8s-auth-token.kubeconfig_sa_secret.data["ca.crt"]
  })
  filename = "../${path.module}/sa_kube_config.temp"
  depends_on = [
    module.k8s-auth-token
  ]
}


module "k8s-ingress-nginx" {
  source             = "./modules/k8s-ingress-nginx"
  lb_nsg_id          = var.nsg_common_internet_access_id
  ingrss_nginx_lb_ip = var.ingrss_nginx_lb_ip
}

