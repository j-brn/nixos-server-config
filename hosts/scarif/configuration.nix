{ self, config, ... }:
let
  host = "scarif.bricker.io";
in
{
  imports = [
    ./hardware-configuration.nix
    ./ipv6.nix

    # shared deployments
    "${self}/deployments/reverse-proxy"
    "${self}/deployments/watchtower"
    (import "${self}/deployments/node-exporter" { inherit host; })

    # garrysmod
    (import "${self}/deployments/garrysmod" {
      gamemode = "terrortown";
      map = "ttt_minecraft_b5";
      workshopId = "854877450";
    })
  ];

  networking.hostName = "scarif";

  boot.loader.grub = {
    enable = true;
    efiSupport = false;
    devices = [ "/dev/sda" ];
  };

  system.stateVersion = "22.11";
}
