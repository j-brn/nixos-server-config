{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./ipv6.nix

    # shared deployments
    ../../deployments/reverse-proxy
    ../../deployments/watchtower

    # deployments
    ./deployments/bookstack
    ./deployments/vaultwarden
    ./deployments/node-exporter
  ];

  networking.hostName = "kashyyyk";

  boot.loader.grub = {
    enable = true;
    efiSupport = false;
    devices = [ "/dev/sda" ];
  };

  system.stateVersion = "22.11";
}
