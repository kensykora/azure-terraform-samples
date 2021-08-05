resource "kubernetes_deployment" "nginx" {
  metadata {
    name      = "nginx"
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "myapp"
      }
    }
    template {
      metadata {
        labels = {
          app = "myapp"
        }
      }
      spec {
        container {
          image = "nginx:1.14.2"
          name  = "nginx"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "kens-k8s-rg"
  location = "North Central US"
}

resource "azurerm_application_insights" "ai" {
  name                = "tf-test-appinsights"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  application_type    = "web"
}

resource "kubernetes_secret" "ai_key" {
  metadata {
    name = "app-insights-instrumentation-key"
  }

  data = {
    instrumentation_key = azurerm_application_insights.ai.instrumentation_key
  }

  type = "Opaque"
}

resource "kubernetes_service" "nginx" {
  metadata {
    name      = "nginx"
  }
  spec {
    selector = {
      app = kubernetes_deployment.nginx.spec.0.template.0.metadata.0.labels.app
    }
    type = "NodePort"
    port {
      node_port   = 30201
      port        = 80
      target_port = 80
    }
  }
}