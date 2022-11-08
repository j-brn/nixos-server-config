{ host, node-exporter-dashboard, dashboardProvider, prometheusDatasource, ... }:
{
  config = {
    services = {
      grafana.service = {
        image = "docker.io/grafana/grafana";
        restart = "unless-stopped";

        environment = {
          "VIRTUAL_HOST" = host;
          "VIRTUAL_PORT" = 3000;
          "LETSENCRYPT_HOST" = host;
        };

        volumes = [
          "${dashboardProvider}:/etc/grafana/provisioning/dashboards/default.yml"
          "${node-exporter-dashboard}:/etc/grafana/provisioning/dashboards/node-exporter.json"
          "${prometheusDatasource}:/etc/grafana/provisioning/datasources/prometheus.yml"
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
