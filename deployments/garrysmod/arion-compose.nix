{ gamemode, map, workshopId, secretEnvFile, ... }:
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
        };

        env_file = [ secretEnvFile ];

        ports = [
          "27015:27015/tcp"
          "27015:27015/udp"
        ];
      };
    };
  };
}
