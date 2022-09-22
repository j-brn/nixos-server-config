{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./ipv6.nix
    ./arion.nix
    ./deployments/reverse-proxy
  ];

  networking.hostName = "kashyyyk";

  boot.loader.grub = {
    enable = true;
    efiSupport = false;
    devices = [ "/dev/sda" ];
  };

  system.stateVersion = "22.11";
}
