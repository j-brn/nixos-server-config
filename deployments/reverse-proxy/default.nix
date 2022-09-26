{
  virtualisation.docker.ensureNetworks = [ "proxy-network" ];

  virtualisation.arion.projects.reverse-proxy.settings = {
    imports = [ ./arion-compose.nix ];
  };
}
