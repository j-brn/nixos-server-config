{
  users.users.admin = {
    isNormalUser = true;
    uid = 1000;

    extraGroups = [
      "docker"
      "wheel"
    ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG3eO5g2TPLcE3pzt/6XiGqGjbAeCr41s+5mSR0aZuHt jonas@chimaera"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICmJcISk17khA5bcCSwV2I4tGdSEHoXqarvMQHxHgyqb github-actions@bricker.io"
    ];
  };

  security.sudo.wheelNeedsPassword = false;
  nix.settings.trusted-users = [ "@wheel" ];
}
