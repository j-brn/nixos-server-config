{ host, node-exporter-dashboard, dashboardProviderFilePath, prometheusDatasourceFilePath, ... }:
{
  config = {
    services = {
      grafana.service = {
        image = "docker.io/grafana/grafana:9.1.6";
        restart = "unless-stopped";

        environment = {
          "VIRTUAL_HOST" = host;
          "VIRTUAL_PORT" = 3000;
          "LETSENCRYPT_HOST" = host;
        };

        volumes = [
          "${dashboardProviderFilePath}:/etc/grafana/provisioning/dashboards/default.yml"
          "${node-exporter-dashboard}:/etc/grafana/provisioning/dashboards/node-exporter.json"
          "${prometheusDatasourceFilePath}:/etc/grafana/provisioning/datasources/prometheus.yml"
          "grafana_data:/var/lib/grafana"
        ];

        networks = [
          "proxy-network"
          "metrics"
        ];
      };
    };

    networks = {
      proxy-network = { external = true; };
      metrics = { external = true; };
    };

    docker-compose.raw.volumes = {
      grafana_data = { };
    };
  };
}
