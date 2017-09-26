job "influxdb" {
	region = "global"
	datacenters = ["dc1"]
	type = "service"

	update {
		stagger = "10s"
		max_parallel = 1
	}

	group "influxdb" {
		count = 1

		restart {
			attempts = 6
			interval = "1m"
			delay = "10s"
			mode = "delay"
		}

		task "influxdb" {
			driver = "docker"

			config {
				image = "influxdb"
				port_map {
					http = 8086
					httpadmin = 8083
				}
			}

			service {
				name = "influxdb"
				tags = ["influxdb"]
				port = "http"
				check {
					name = "influxdb alive"
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
					port "http" {
						static = 8086
					}
					port "httpadmin" {
						static = 8083
					}
				}
			}
		}
	}
}
