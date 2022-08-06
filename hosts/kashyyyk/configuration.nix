{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "kashyyyk";

  boot.loader.grub = {
    enable = true;
    efiSupport = false;
    devices = [ "/dev/sda" ];
  };

  system.stateVersion = "22.11";
}
