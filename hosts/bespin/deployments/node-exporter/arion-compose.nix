{
  config = {
    services = {
      node-exporter.service = {
        image = "prom/node-exporter";
        restart = "unless-stopped";

        environment = {
          "VIRTUAL_HOST" = "bespin.bricker.io";
          "LETSENCRYPT_HOST" = "bespin.bricker.io";
          "VIRTUAL_PORT" = 9100;
          "VIRTUAL_PATH" = "/metrics/node";
          "VIRTUAL_DEST" = "/metrics";
        };

        volumes = [
          "/run/node-exporter-auth.yml:/etc/node-exporter/auth.yml:ro"
          "/proc:/host/proc:ro"
          "/sys:/host/sys:ro"
          "/:/rootfs:ro"
        ];

        networks = [
          "proxy-network"
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
    };
  };
}
