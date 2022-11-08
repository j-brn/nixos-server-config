{ self, config, ... }:
let
  host = "kashyyyk.bricker.io";
in
{
  imports = [
    ./hardware-configuration.nix
    ./ipv6.nix

    # deployments
    "${self}/deployments/reverse-proxy"
    "${self}/deployments/watchtower"

    (import "${self}/deployments/node-exporter" { inherit host; })
    (import "${self}/deployments/bookstack" { inherit host; })
    (import "${self}/deployments/vaultwarden" { inherit host; })
  ];

  networking.hostName = "kashyyyk";

  boot.loader.grub = {
    enable = true;
    efiSupport = false;
    devices = [ "/dev/sda" ];
  };

  system.stateVersion = "22.05";
}
