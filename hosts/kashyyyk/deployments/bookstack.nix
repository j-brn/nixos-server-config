{ self, config, ... }:
{
  age.secrets.bookstackEnvironment = {
    file = "${self}/secrets/bookstackEnvironment.env.age";
  };

  virtualisation.docker.ensureNetworks = [ "proxy-network" ];

  virtualisation.arion.projects.bookstack.settings = {
    imports = [
      (import "${self}/deployments/bookstack.nix" {
        host = "bookstack.bricker.io";
        bookstackEnvironmentFilePath = config.age.secrets.bookstackEnvironment.path;
      })
    ];
  };
}
