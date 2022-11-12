{ host, authConfigPath, ... }:
{
  config = {
    services = {
      node-exporter.service = {
        image = "prom/node-exporter:v1.4.0";
        restart = "unless-stopped";

        environment = {
          "VIRTUAL_HOST" = host;
          "LETSENCRYPT_HOST" = host;
          "VIRTUAL_PORT" = 9100;
          "VIRTUAL_PATH" = "/metrics/node";
          "VIRTUAL_DEST" = "/metrics";
        };

        volumes = [
          "${authConfigPath}:/etc/node-exporter/auth.yml:ro"
          "/proc:/host/proc:ro"
          "/sys:/host/sys:ro"
          "/:/rootfs:ro"
        ];

        networks = [
          "proxy-network"
          "metrics"
        ];

        command = [
          "--web.config=/etc/node-exporter/auth.yml"
          "--path.procfs=/host/proc"
          "--path.rootfs=/rootfs"
          "--path.sysfs=/host/sys"
          "--collector.filesystem.mount-points-exclude=^/(sys|proc|dev|host|etc)($$|/)"
        ];
      };
    };

    networks = {
      proxy-network = {
        external = true;
      };

      metrics = {
        external = true;
      };
    };
  };
}
