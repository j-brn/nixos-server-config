{ gamemode, map, workshopId }: { self, config, ... }:
{
  age.secrets = {
    "garrysmod/secret-environment.env" = {
      file = "${self}/secrets/garrysmod/secret-environment.env.age";
    };

    "garrysmod/server.cfg" = {
      file = "${self}/secrets/garrysmod/server.cfg.age";
    };
  };

  virtualisation.arion.projects.garrysmod-ttt.settings = {
    imports = [
      (import ./arion-compose.nix {
        inherit gamemode;
        inherit map;
        inherit workshopId;
        configFile = config.age.secrets."garrysmod/server.cfg".path;
        secretEnvFile = config.age.secrets."garrysmod/secret-environment.env".path;
      })
    ];
  };
}
