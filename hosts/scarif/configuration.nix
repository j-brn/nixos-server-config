{ self, config, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./ipv6.nix

    # deployments
    "${self}/deployments/reverse-proxy"
    "${self}/deployments/watchtower"

    (import "${self}/deployments/node-exporter" { host = "scarif.bricker.io"; })

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
