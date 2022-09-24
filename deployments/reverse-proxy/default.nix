{
  imports = [
    ./docker-network.nix
  ];

  virtualisation.arion.projects.reverse-proxy.settings = {
    imports = [ ./arion-compose.nix ];
  };
}
