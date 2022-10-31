{ self, config, ... }:
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
      (import "${self}/deployments/prometheus.nix" {
        prometheusConfigPath = config.age.secrets."prometheus/prometheus.yml".path;
        prometheusAuthConfigPath = config.age.secrets."prometheus/auth.yml".path;
      })
    ];
  };
}
