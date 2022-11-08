{ host, bookstackEnvironment, ... }:
{
  config = {
    services = {
      bookstack.service = {
        image = "lscr.io/linuxserver/bookstack";
        restart = "unless-stopped";
        environment = {
          "PUID" = 1000;
          "PGID" = 1000;
          "APP_URL" = "https://${host}";
          "VIRTUAL_HOST" = host;
          "LETSENCRYPT_HOST" = host;
        };
        env_file = [ bookstackEnvironment ];
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
        env_file = [ bookstackEnvironment ];
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
