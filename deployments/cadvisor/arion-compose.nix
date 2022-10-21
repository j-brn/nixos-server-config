{ host, htpasswdFile }:
{
  config = {
    services = {
      cadvisor.service = {
        image = "gcr.io/cadvisor/cadvisor:v0.45";
        restart = "unless-stopped";
        privileged = true;

        environment = {
          "VIRTUAL_HOST" = host;
          "VIRTUAL_PORT" = 8080;
          "VIRTUAL_PATH" = "/metrics/cadvisor";
          "VIRTUAL_DEST" = "/metrics";
          "LETSENCRYPT_HOST" = host;
        };

        volumes = [
          "/etc/localtime:/etc/localtime:ro"
          "/etc/timezone:/etc/timezone:ro"
          "/:/rootfs:ro"
          "/var/run:/var/run:ro"
          "/sys:/sys:ro"
          "/var/lib/docker/:/var/lib/docker:ro"
          "/dev/disk/:/dev/disk:ro"
        ];

        devices = [ "/dev/kmsg" ];

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
  };
}

