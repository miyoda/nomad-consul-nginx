job "hello-java" {
  datacenters = ["dc1"]
  type = "service"

  update {
    max_parallel = 1
  }

  group "hello-java" {
    count = 1

    task "hello-java" {
      driver = "hello-java"

      config {
        jar_path = "local/hello2.jar"
        jvm_options = ["-XX:-UseCompressedOops", "-Xmx2048m", "-Xms256m"]
      }
      artifact {
       source = "https://bitbucket.org/miyoda/nomad-repo/raw/31e5739c551bb33f6b6cd41cbb2816b1d5e1130d/hello2.jar"
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
