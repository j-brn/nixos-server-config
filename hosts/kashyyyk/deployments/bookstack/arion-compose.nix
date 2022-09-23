{ config, ... }:
{
  config = {
    services = {
      bookstack.service = {
        image = "lscr.io/linuxserver/bookstack";
        restart = "unless-stopped";
        environment = {
          "PUID" = 1000;
          "PGID" = 1000;
          "APP_URL" = "https://bookstack.bricker.io";
          "VIRTUAL_HOST" = "bookstack.bricker.io";
          "LETSENCRYPT_HOST" = "bookstack.bricker.io";
        };
        env_file = [ "/run/bookstack_database.env" ];
        volumes = [ "bookstack_data:/config" ];
        networks = [
          "proxy-network"
          "bookstack"
        ];
        depends_on = [ "mariadb" ];
      };

      mariadb.service = {
        image = "lscr.io/linuxserver/mariadb";
        environment = {
          "PUID" = 1000;
          "PGID" = 1000;
          "TZ" = "Europe/Berlin";
        };
        env_file = [ "/run/bookstack_database.env" ];
        volumes = [ "mariadb_data:/config" ];
        networks = [ "bookstack" ];
      };
    };

    networks = {
      bookstack = { };
      proxy-network = {
        external = true;
      };
    };

    docker-compose.raw = {
      volumes = {
        bookstack_data = { };
        mariadb_data = { };
      };
    };
  };
}
