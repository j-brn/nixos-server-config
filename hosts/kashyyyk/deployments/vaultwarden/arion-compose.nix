{
  config = {
    services = {
      vaultwarden.service = {
        image = "vaultwarden/server:latest";
        restart = "unless-stopped";
        environment = {
          "WEBSOCKET_ENABLED" = "true";
          "SIGNUPS_ALLOWED" = "false";
          "VIRTUAL_HOST" = "vaultwarden.bricker.io";
          "VIRTUAL_PORT" = 80;
          "LETSENCRYPT_HOST" = "vaultwarden.bricker.io";
        };
        env_file = [
          "/run/vaultwarden.env"
        ];
        volumes = [
          "vaultwarden_data:/data"
        ];
        networks = [
          "proxy-network"
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
        vaultwarden_data = { };
      };
    };
  };
}
