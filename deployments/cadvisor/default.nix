{ host, self, config, pkgs, ... }:
let
  nginxBasicAuthConfig = pkgs.writeText "${host}"
    ''
      location /metrics/cadvisor {
        auth_basic           "cadvisor";
        auth_basic_user_file /auth/cadvisor/htpasswd;
      }
    '';
in
{
  age.secrets.cadvisorHtpasswdFile = {
    file = "${self}/secrets/cadvisor-htpasswd.age";
  };

  virtualisation.docker.ensureNetworks = [
    "proxy-network"
    "metrics"
  ];

  virtualisation.arion.projects.reverse-proxy.settings.config = {
    services.nginx-proxy.service = {
      volumes = [
        "${config.age.secrets.cadvisorHtpasswdFile.path}:/auth/cadvisor/htpasswd:ro"
        "${nginxBasicAuthConfig}:/etc/nginx/vhost.d/${host}_location"
      ];
    };
  };

  virtualisation.arion.projects.cadvisor.settings = {
    imports = [
      (import ./arion-compose.nix {
        inherit host;
        htpasswdFile = config.age.secrets.cadvisorHtpasswdFile.path;
      })
    ];
  };
}
