{ gamemode, map, workshopId }: { self, config, ... }:
{
  age.secrets."garrysmod/secret-environment.env" = {
    file = "${self}/secrets/garrysmod/secret-environment.env.age";
  };

  virtualisation.arion.projects.garrysmod-ttt.settings = {
    imports = [
      (import ./arion-compose.nix {
        inherit gamemode;
        inherit map;
        inherit workshopId;
        secretEnvFile = config.age.secrets."garrysmod/secret-environment.env".path;
      })
    ];
  };
}
