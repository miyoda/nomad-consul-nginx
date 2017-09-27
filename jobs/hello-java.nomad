job "hello-java" {
  datacenters = ["dc1"]
  type = "service"

  update {
    max_parallel = 1
  }

  group "hello-java" {
    count = 2

    task "hello-java" {
      driver = "hello-java"

      config {
        jar_path = "local/hello.jar"
        jvm_options = ["-XX:-UseCompressedOops", "-Xmx2048m", "-Xms256m"]
      }
      artifact {
       source = "https://github.com/miyoda/nomad-consul-nginx/blob/master/jobs/hello.jar?raw=true"
      }
      resources {
        cpu    = 500
        memory = 128

        network {
          mbits = 10

          port "http" {
            static = 8080
          }

        }
      }
    }
   }

}
