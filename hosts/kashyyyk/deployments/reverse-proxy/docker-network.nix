{ config, ... }:
{
  systemd.services.create-reverse-proxy-network = {
    description = "Create the docker network for the nginx reverse proxy";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig.Type = "oneshot";
    script =
      let
        dockercli = "${config.virtualisation.docker.package}/bin/docker";
        network = "reverse-proxy";
      in ''
        check=$(${dockercli} network ls | grep "${network}" || true)
        if [ -z "$check" ]; then
          ${dockercli} network create ${network}
        else
          echo "${network} already exists in docker"
        fi
      '';
  };
}