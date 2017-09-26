job "hello-docker" {
  region      = "global"
  datacenters = ["dc1"]
  type        = "service"
  priority    = 50

  update {
    stagger      = "10s"
    max_parallel = 1
  }

  group "hello-docker" {
    count = 2

    restart {
      attempts = 10
      interval = "5m"
      delay    = "25s"
      mode     = "delay"
    }

    task "hello-docker" {
      driver = "docker"

      config {
        image = "dockercloud/hello-world"

        port_map {
          http = 80
        }
      }

      service {
        name = "hello-docker"
        tags = ["global", "urlprefix-helloworld.com/"]
        port = "http"

        check {
          name     = "hello-docker alive"
          type     = "tcp"
          interval = "10s"
          timeout  = "2s"
        }
      }

      resources {
        cpu    = 500
        memory = 128

        network {
          mbits = 10

          port "http" {
            static = 80
          }

        }
      }

      logs {
        max_files     = 10
        max_file_size = 15
      }

      kill_timeout = "20s"
    }
  }
}
