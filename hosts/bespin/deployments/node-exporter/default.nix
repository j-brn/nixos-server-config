{
  age.secrets.node-exporter-auth_yml = {
    file = ../../../../secrets/node-exporter-auth.yml.age;
    path = "/run/node-exporter-auth.yml";
    owner = "nobody";
  };

  virtualisation.docker.ensureNetworks = [
    "proxy-network"
    "metrics"
  ];

  virtualisation.arion.projects.node-exporter.settings = {
    imports = [
      ./arion-compose.nix
    ];
  };
}
