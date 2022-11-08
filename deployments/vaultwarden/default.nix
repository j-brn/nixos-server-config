{ host }: { self, config, ... }:
{
  age.secrets."vaultwarden/environment.env" = {
    file = "${self}/secrets/vaultwarden/environment.env.age";
  };

  virtualisation.docker.ensureNetworks = [ "proxy-network" ];

  virtualisation.arion.projects.vaultwarden.settings = {
    imports = [
      (import ./arion-compose.nix {
        inherit host;
        vaultwardenEnvironment = config.age.secrets."vaultwarden/environment.env".path;
      })
    ];
  };
}
