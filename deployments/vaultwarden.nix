{ host, environmentFilePath }:
{
  config = {
    services = {
      vaultwarden.service = {
        image = "vaultwarden/server:latest";
        restart = "unless-stopped";
        environment = {
          "WEBSOCKET_ENABLED" = "true";
          "SIGNUPS_ALLOWED" = "false";
          "VIRTUAL_HOST" = host;
          "LETSENCRYPT_HOST" = host;
          "VIRTUAL_PORT" = 80;
        };
        env_file = [ environmentFilePath ];
        volumes = [ "vaultwarden_data:/data" ];
        networks = [ "proxy-network" ];
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
