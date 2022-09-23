{ config, ... }:
{
  config = {
    services = {
      bookstack.service = {
        image = "lscr.io/linuxserver/bookstack";
        restart = "unless-stopped";

        environment = [
          "PUID=1000"
          "PGID=1000"
          "APP_URL=https://bookstack.bricker.io"
          "VIRTUAL_HOST=bookstack.bricker.io"
          "VIRTUAL_PORT=6875"
          "LETSENCRYPT_HOST=bookstack.bricker.io"
        ];
        env_file = config.age.secrets.bookstack_database.path;

        ports = [ "6875:80" ];
        volumes = [ "bookstack_data:/config" ];
        networks = [ "proxy-network" ];
        depends_on = [ "bookstack_db" ];
      };

      mariadb.service = {
        image = "lscr.io/linuxserver/mariadb";
        environment = [
          "PUID=1000"
          "PGID=1000"
          "TZ=Europe/Berlin"
        ];
        env_file = config.age.secrets.bookstack_database.path;
        volumes = [ "mariadb_data:/config" ];
      };
    };

    networks = {
      proxy-network = {
        external = true;
      };
    };

    docker-compose.raw = {
      volumes = {
        bookstack_data = {};
        mariadb_data = {};
      };
    };
  };
}