{ self, config, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./ipv6.nix

    # deployments
    "${self}/deployments/reverse-proxy"
    "${self}/deployments/watchtower"

    (import "${self}/deployments/node-exporter" { host = "kashyyyk.bricker.io"; })
    (import "${self}/deployments/bookstack" { host = "bookstack.bricker.io"; })
    (import "${self}/deployments/vaultwarden" { host = "vaultwarden.bricker.io"; })
  ];

  networking.hostName = "kashyyyk";

  boot.loader.grub = {
    enable = true;
    efiSupport = false;
    devices = [ "/dev/sda" ];
  };

  system.stateVersion = "22.05";
}
