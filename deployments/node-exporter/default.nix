{ host }: { self, config, ... }:
{
  age.secrets."node-exporter/auth.yml" = {
    file = "${self}/secrets/node-exporter/auth.yml.age";
    owner = "nobody";
  };

  virtualisation.docker.ensureNetworks = [
    "proxy-network"
    "metrics"
  ];

  virtualisation.arion.projects.node-exporter.settings = {
    imports = [
      (import ./arion-compose.nix {
        inherit host;
        authConfigPath = config.age.secrets."node-exporter/auth.yml".path;
      })
    ];
  };
}
