{ host }: { self, config, ... }:
{
  age.secrets = {
    "prometheus/prometheus.yml" = {
      file = "${self}/secrets/prometheus/prometheus.yml.age";
      owner = "nobody";
    };

    "prometheus/auth.yml" = {
      file = "${self}/secrets/prometheus/auth.yml.age";
      owner = "nobody";
    };
  };

  virtualisation.docker.ensureNetworks = [
    "proxy-network"
    "metrics"
  ];

  virtualisation.arion.projects.prometheus.settings = {
    imports = [
      (import ./arion-compose.nix {
        inherit host;
        prometheusConfig = config.age.secrets."prometheus/prometheus.yml".path;
        prometheusAuthConfig = config.age.secrets."prometheus/auth.yml".path;
      })
    ];
  };
}
