{ self, config, ... }:
{
  age.secrets.vaultwardenEnvFile = {
    file = "${self}/secrets/vaultwarden.env.age";
  };

  virtualisation.docker.ensureNetworks = [ "proxy-network" ];

  virtualisation.arion.projects.vaultwarden.settings = {
    imports = [
      (import "${self}/deployments/vaultwarden.nix" {
        host = "vaultwarden.bricker.io";
        environmentFilePath = config.age.secrets.vaultwardenEnvFile.path;
      })
    ];
  };
}
