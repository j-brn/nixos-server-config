{
  config = {
    services = {
       nginx-proxy.service = {
         image = "nginxproxy/nginx-proxy";
         restart = "always";

         ports = [
           "80:80"
           "443:443"
           "1201:1201"
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
           "com.github.jrcs.letsencrypt_nginx_proxy_companion.docker_gen" = "";
         };

         networks = [
           "reverse-proxy"
         ];
       };

       acme-compantion.service = {
         image = "nginxproxy/acme-companion";
         restart = "always";

         volumes = [
           "dhparam:/etc/nginx/dhparam"
           "certs:/etc/nginx/certs:rw"
           "acme:/etc/acme.sh"
           "/var/run/docker.sock:/tmp/docker.sock:ro"
         ];
       };
     };

     docker-compose.raw = {
       volumes = {
         conf = {};
         vhost = {};
         html = {};
         dhparam = {};
         certs = {};
         acme = {};
       };

       networks = {
         reverse-proxy = {
           external = true;
         };
       };
     };
  };
}
