{ self, config, ... }:
{
  age.secrets.node-exporter-auth_yml = {
    file = "${self}/secrets/node-exporter-auth.yml.age";
    owner = "nobody";
  };

  virtualisation.docker.ensureNetworks = [
    "proxy-network"
    "metrics"
  ];

  virtualisation.arion.projects.node-exporter.settings = {
    imports = [
      (import "${self}/deployments/node-exporter.nix" {
        host = "bespin.bricker.io";
        authConfigPath = config.age.secrets.node-exporter-auth_yml.path;
      })
    ];
  };
}
