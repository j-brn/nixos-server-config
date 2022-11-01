{ gamemode, map, workshopId, configFile, secretEnvFile, ... }:
{
  config = {
    services = {
      garrysmod.service = {
        image = "hackebein/garrysmod";
        restart = "unless-stopped";
        tty = true;

        environment = {
          "GAMEMODE" = gamemode;
          "MAP" = map;
          "WORKSHOP" = workshopId;
          "WORKSHOPDL" = workshopId;
          "TICKRATE" = "128";
        };

        env_file = [ secretEnvFile ];

        ports = [
          "27015:27015/tcp"
          "27015:27015/udp"
        ];

        volumes = [
          "${configFile}:/opt/steam/garrysmod/cfg/server.cfg"
          "overlay:/opt/overlay"
          "cache:/opt/steam"
        ];
      };
    };

    docker-compose.raw = {
      volumes = {
        overlay = { };
        cache = { };
      };
    };
  };
}
