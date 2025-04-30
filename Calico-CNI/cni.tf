terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.26"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path = var.kubeconfig_path
  }
}

resource "helm_release" "calico" {
  name       = "calico"
  namespace  = "tigera-operator"
  repository = "https://projectcalico.docs.tigera.io/charts"
  chart      = "tigera-operator"
  version    = "v3.27.0"
  create_namespace = true

  values = [
    yamlencode({
      installation = {
        kubernetesProvider = "EKS"
        cni = {
          type = "Calico"
        }
        calicoNetwork = {
          bgp = "Disabled"
          ipPools = [
            {
              cidr = "192.168.0.0/16"
              encapsulation = "VXLANCrossSubnet"
              natOutgoing   = "Enabled"
              nodeSelector  = "all()"
            }
          ]
        }
      }
      apiServer = {
        enabled = true
      }
    })
  ]
}

resource "kubernetes_manifest" "default_network_policy" {
  manifest = {
    apiVersion = "networking.k8s.io/v1"
    kind       = "NetworkPolicy"
    metadata = {
      name      = "default-deny-all"
      namespace = "default"
    }
    spec = {
      podSelector = {}
      policyTypes = ["Ingress", "Egress"]
    }
  }
}
