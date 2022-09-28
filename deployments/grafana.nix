{ host, node-exporter-dashboard, ... }:
{
  config = {
    services = {
      grafana.service = {
        image = "grafana/grafana";
        restart = "unless-stopped";

        environment = {
          "VIRTUAL_HOST" = host;
          "VIRTUAL_PORT" = 3000;
          "LETSENCRYPT_HOST" = host;
        };

        volumes = [
          "${node-exporter-dashboard}:/etc/grafana/provisioning/dashboards/node-exporter.json"
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
