{
  config = {
    services = {
      prometheus.service = {
        image = "prom/prometheus";
        restart = "unless-stopped";

        environment = {
          "VIRTUAL_HOST" = "prometheus.bricker.io";
          "VIRTUAL_PORT" = 9090;
          "LETSENCRYPT_HOST" = "prometheus.bricker.io";
        };

        volumes = [
          "prometheus_data:/prometheus"
          "/run/prometheus.yml:/etc/prometheus/prometheus.yml"
          "/run/prometheus-auth.yml:/etc/prometheus/prometheus-auth.yml"
        ];

        networks = [
          "proxy-network"
        ];

        command = [
          "--config.file=/etc/prometheus/prometheus.yml"
          "--web.config.file=/etc/prometheus/prometheus-auth.yml"
          "--storage.tsdb.path=/prometheus"
          "--web.console.libraries=/usr/share/prometheus/console_libraries"
          "--web.console.templates=/usr/share/prometheus/consoles"
        ];
      };
    };

    networks = {
      proxy-network = {
        external = true;
      };
    };

    docker-compose.raw = {
      volumes = {
        prometheus_data = { };
      };
    };
  };
}
