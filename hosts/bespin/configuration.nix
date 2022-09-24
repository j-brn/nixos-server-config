{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./ipv6.nix
  ];

  networking.hostName = "bespin";

  boot.loader.grub = {
    enable = true;
    efiSupport = false;
    devices = [ "/dev/sda" ];
  };

  system.stateVersion = "22.11";
}
