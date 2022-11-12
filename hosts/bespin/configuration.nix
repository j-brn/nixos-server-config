{ self, config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./ipv6.nix

    # shared deployments
    "${self}/deployments/reverse-proxy"
    "${self}/deployments/watchtower"

    (import "${self}/deployments/node-exporter" { host = "bespin.bricker.io"; })
    (import "${self}/deployments/prometheus" { host = "prometheus.bricker.io"; })
    (import "${self}/deployments/grafana" { host = "grafana.bricker.io"; })
  ];

  networking.hostName = "bespin";

  boot.loader.grub = {
    enable = true;
    efiSupport = false;
    devices = [ "/dev/sda" ];
  };

  system.stateVersion = "22.05";
}
