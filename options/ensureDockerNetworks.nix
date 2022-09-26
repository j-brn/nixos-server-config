{ lib, config, ... }:

with lib;

let
  networkNames = config.virtualisation.docker.ensureNetworks;
  makeEnsureDockerNetworkService = networkName:
    {
      name = "ensure-docker-network-${networkName}";
      value =
        {
          description = "ensure that the docker network ${networkName} is present";
          after = [ "network.target" ];
          wantedBy = [ "multi-user.target" ];

          serviceConfig.Type = "oneshot";
          script =
            let
              dockercli = "${config.virtualisation.docker.package}/bin/docker";
            in
            ''
              check=$(${dockercli} network ls | grep "${networkName}" || true)
              if [ -z "$check" ]; then
                ${dockercli} network create ${networkName}
              else
                echo "${networkName} already exists in docker"
              fi
            '';
        };
    };
in
{
  options.virtualisation.docker.ensureNetworks = mkOption {
    default = [ ];
    example = [ "reverse-proxy" "metrics" ];
    type = types.listOf types.str;
    description = lib.mdDoc ''
      List of docker networks that must be present. This will create a systemd oneshot service for each network that
      ensures that the net is already present or creates it if necessary.
    '';
  };

  config.systemd.services = listToAttrs (map (makeEnsureDockerNetworkService) networkNames);
}
