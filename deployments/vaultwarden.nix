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
          "DOMAIN" = "https://${host}";

          # TODO: find a better mailing solution
          "SMTP_HOST" = "mailer";
          "SMTP_FROM" = "noreply@vaultwarden.bricker.io";
          "SMTP_PORT" = 25;
          # OK because this mailer is only reachable from within the "mailer" network
          "SMTP_SSL" = "false";
        };
        env_file = [ environmentFilePath ];
        volumes = [ "vaultwarden_data:/data" ];
        networks = [
          "proxy-network"
          "mailer"
        ];
      };

      mailer.service = {
        image = "ixdotai/smtp:latest";
        restart = "unless-stopped";
        networks = [ "mailer" ];
      };
    };

    networks = {
      proxy-network = {
        external = true;
      };
      mailer = {};
    };

    docker-compose.raw = {
      volumes = {
        vaultwarden_data = { };
      };
    };
  };
}
