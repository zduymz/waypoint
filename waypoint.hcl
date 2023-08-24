project = "dmai-test"

runner {
  data_source "git" {
    url = "https://github.com/zduymz/waypoint.git"
  }
}

app "dmai0" {
  runner {
    profile = "docker-01H8JNQF38TP6Z86SEKAV90D4A"
  }
  build {
    use "docker" {
      disable_entrypoint = true
    }
    registry {
      use "docker" {
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
