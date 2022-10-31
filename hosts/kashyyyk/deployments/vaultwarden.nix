{ self, config, ... }:
{
  age.secrets."vaultwarden/environment.env" = {
    file = "${self}/secrets/vaultwarden/environment.env.age";
  };

  virtualisation.docker.ensureNetworks = [ "proxy-network" ];

  virtualisation.arion.projects.vaultwarden.settings = {
    imports = [
      (import "${self}/deployments/vaultwarden.nix" {
        host = "vaultwarden.bricker.io";
        environmentFilePath = config.age.secrets."vaultwarden/environment.env".path;
      })
    ];
  };
}
