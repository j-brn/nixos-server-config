{
  users.users.admin = {
    isNormalUser = true;
    uid = 1000;

    extraGroups = [
      "docker"
      "wheel"
    ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG3eO5g2TPLcE3pzt/6XiGqGjbAeCr41s+5mSR0aZuHt jonas@thinkpad-jb"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINmS1P4VKH5w/7vDI+wMTp96E1SjWv7TNOE8g5ziVRTD openpgp:0x872B10AD"
    ];
  };

  security.sudo.wheelNeedsPassword = false;
  nix.settings.trusted-users = [ "@wheel" ];
}
