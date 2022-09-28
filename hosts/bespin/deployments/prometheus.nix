{ self, config, ... }:
{
  age.secrets = {
    prometheusConfig = {
      file = "${self}/secrets/prometheus.yml.age";
      owner = "nobody";
    };

    prometheusAuthConfig = {
      file = "${self}/secrets/prometheus-auth.yml.age";
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
        prometheusConfigPath = config.age.secrets.prometheusConfig.path;
        prometheusAuthConfigPath = config.age.secrets.prometheusAuthConfig.path;
      })
    ];
  };
}
