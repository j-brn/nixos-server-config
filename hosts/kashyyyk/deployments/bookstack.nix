{ self, config, ... }:
{
  age.secrets."bookstack/environment.env" = {
    file = "${self}/secrets/bookstack/environment.env.age";
  };

  virtualisation.docker.ensureNetworks = [ "proxy-network" ];

  virtualisation.arion.projects.bookstack.settings = {
    imports = [
      (import "${self}/deployments/bookstack.nix" {
        host = "bookstack.bricker.io";
        bookstackEnvironmentFilePath = config.age.secrets."bookstack/environment.env".path;
      })
    ];
  };
}
