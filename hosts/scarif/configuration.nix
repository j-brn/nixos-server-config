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
      map = "ttt_camel_v1";
      workshopId = "720833518";
    })
  ];

  networking.hostName = "scarif";

  boot.loader.grub = {
    enable = true;
    efiSupport = false;
    devices = [ "/dev/sda" ];
  };

  system.stateVersion = "22.05";
}
