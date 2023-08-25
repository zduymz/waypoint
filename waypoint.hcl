project = "dmai-test"

runner {
  data_source "git" {
    url = "https://github.com/zduymz/waypoint.git"
  }
  profile = "docker-01H8JNQF38TP6Z86SEKAV90D4A"
}

app "dmai0" {
  build {
    use "docker-pull" {
      image              = "nginx"
      tag                = "latest"
      disable_entrypoint = true
    }
    registry {
      use "docker" {
        image    = "duym/nginx-test"
        tag      = "000"
        username = var.registry_username
        password = var.registry_password
        local = true
      }
    }

  }
  deploy {
    use "exec" {
      command = ["echo", "1800"]
    }
  }
}

app "dmai1" {
  build {
    use "null" {}
  }
  deploy {
    use "exec" {
      command = ["echo", "1800"]
    }
  }
}

variable "registry_username" {
  type      = string
  default   = ""
  env       = ["REGISTRY_USERNAME"]
  sensitive = true
}

variable "registry_password" {
  type      = string
  default   = ""
  env       = ["REGISTRY_PASSWORD"]
  sensitive = true
}
