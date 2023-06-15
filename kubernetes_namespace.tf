# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace_v1
resource "kubernetes_namespace_v1" "ns" {

  metadata {
    name = var.kube_namespace
#Annotations are key-value pairs used to attach arbitrary metadata to Kubernetes objects
    annotations = {
      name = "sample-annotation"
    }
#Labels are key-value pairs attached to Kubernetes objects to identify and group related resources
    labels = {
      tier = "frontend"
    }
  }
}
