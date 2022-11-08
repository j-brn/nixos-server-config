{ host }: { self, config, ... }:
{
  age.secrets."bookstack/environment.env" = {
    file = "${self}/secrets/bookstack/environment.env.age";
  };

  virtualisation.docker.ensureNetworks = [ "proxy-network" ];

  virtualisation.arion.projects.bookstack.settings = {
    imports = [
      (import ./arion-compose.nix {
        inherit host;
        bookstackEnvironment = config.age.secrets."bookstack/environment.env".path;
      })
    ];
  };
}
