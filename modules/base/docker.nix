{ pkgs, ... }:
{
  virtualisation.docker = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [ docker ];
  users.users.admin.extraGroups = [ "docker" ];
}
