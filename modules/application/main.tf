

resource "docker_image" "ruby-test-app" {
  name = var.image
}

resource "docker_container" "ruby-test-app" {
  image = docker_image.ruby-test-app.latest
  name  = "ruby-test-app"
  env = [
    "PORT=4000",
  ]
  ports {
    internal = 4000
    external = 80
  }
  restart = "unless-stopped"
}
