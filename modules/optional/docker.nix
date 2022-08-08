{ pkgs, ... }:
{
  virtualisation.docker = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    docker
    docker-compose
  ];

  users.users.admin.extraGroups = [ "docker" ];
}
