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
       source = "https://bitbucket.org/miyoda/nomad-repo/raw/4efb03e04a2b896610d2f86fccc2a183a482bb70/hello.jar"
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
