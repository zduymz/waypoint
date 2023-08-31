project = "dmai-test"

runner {
  data_source "git" {
    url = "https://github.com/zduymz/waypoint.git"
  }
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
        image = "duym/nginx-test"
        tag   = "000"
        auth {
          serverAddress = "https://index.docker.io/v1/"
          username      = var.registry_username
          password      = var.registry_password
        }
        local = true
      }
    }

  }
  deploy {
    use "docker" {
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


app "dmai2" {
  runner {
    profile = "docker-01H8JNQF38TP6Z86SEKAV90D4A"
  }
  build {
    use "apx-frontend" {
      wait = 180
    }
  }
  deploy {
    use "apx-frontend" {
      wait = 120
    }
  }
}

app "dmai3" {
  runner {
    profile = "docker-01H8JNQF38TP6Z86SEKAV90D4A"
  }
  build {
    use "apx-ecr-scan" {
      severity        = "high"
      severity_detail = false
      repository      = "088921318242.dkr.ecr.us-west-2.amazonaws.com/base"
      tag             = "python39"
    }
  }
  deploy {
    use "apx-frontend" {
      wait = 1
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
