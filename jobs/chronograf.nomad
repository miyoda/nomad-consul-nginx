job "chronograf" {
	region = "global"
	datacenters = ["dc1"]
	type = "service"

	update {
		stagger = "10s"
		max_parallel = 1
	}

	group "chronograf" {
    count = 1

		restart {
			attempts = 6
			interval = "1m"
			delay = "10s"
			mode = "delay"
		}

		task "chronograf" {
			driver = "docker"

			config {
				image = "chronograf"
				port_map {
					http = 10000
				}
			}

			service {
				name = "chronograf"
				tags = ["chronograf"]
				port = "http"
				check {
					name = "chronograf alive"
					type = "tcp"
					interval = "10s"
					timeout = "2s"
				}
			}

			resources {
				cpu = 500
				memory = 256
				network {
					mbits = 1
					port "http" {}
				}
			}
		}
	}
}
