terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.0"
    }
  }
}

provider "docker" {}
# Creating an image to be used later
resource "docker_image" "nginx" {
  name         = "nginx:1.19.6"
  keep_locally = true    // keep image after "destroy"
}
# Creating a container using created docker image
resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id // Reference to nginx resource 
  name  = "tutorial"
  ports {
    internal = 80
    external = 2224
  }
}
