{ self, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./ipv6.nix

    # shared deployments
    "${self}/deployments/reverse-proxy"
    "${self}/deployments/watchtower"

    # deployments
    ./deployments/bookstack.nix
    ./deployments/vaultwarden.nix
    ./deployments/node-exporter.nix
  ];

  networking.hostName = "kashyyyk";

  boot.loader.grub = {
    enable = true;
    efiSupport = false;
    devices = [ "/dev/sda" ];
  };

  system.stateVersion = "22.11";
}
