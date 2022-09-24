{
  config = {
    services = {
      watchtower.service = {
        image = "containrrr/watchtower";
        volumes = [
          "/var/run/docker.sock:/var/run/docker.sock"
        ];
        command = "--interval 30";
      };
    };
  };
}
