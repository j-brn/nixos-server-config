{
  config = {
    services = {
      nginx-proxy.service = {
        image = "nginxproxy/nginx-proxy:1.0.1";
        restart = "always";

        ports = [
          "80:80"
          "443:443"
        ];

        volumes = [
          "conf:/etc/nginx/conf.d"
          "vhost:/etc/nginx/vhost.d"
          "html:/usr/share/nginx/html"
          "dhparam:/etc/nginx/dhparam"
          "certs:/etc/nginx/certs:ro"
          "/var/run/docker.sock:/tmp/docker.sock:ro"
        ];

        labels = {
          "com.github.jrcs.letsencrypt_nginx_proxy_companion.nginx_proxy" = "";
        };

        networks = [
          "proxy-network"
        ];
      };

      acme-compantion.service = {
        image = "nginxproxy/acme-companion:2.2.1";
        restart = "always";

        volumes = [
          "vhost:/etc/nginx/vhost.d"
          "html:/usr/share/nginx/html"
          "certs:/etc/nginx/certs:rw"
          "acme:/etc/acme.sh"
          "/var/run/docker.sock:/var/run/docker.sock:ro"
        ];

        depends_on = [ "nginx-proxy" ];
      };
    };

    networks = {
      proxy-network = {
        external = true;
      };
    };

    docker-compose.raw = {
      volumes = {
        conf = { };
        vhost = { };
        html = { };
        dhparam = { };
        certs = { };
        acme = { };
      };
    };
  };
}
