{ self, config, pkgs, ... }:
let
  host = "bespin.bricker.io";
in
{
  imports = [
    ./hardware-configuration.nix
    ./ipv6.nix

    # shared deployments
    "${self}/deployments/reverse-proxy"
    "${self}/deployments/watchtower"
    (import "${self}/deployments/node-exporter" { inherit host; })
    #(import "${self}/deployments/cadvisor" { inherit host; })
    (import "${self}/deployments/prometheus" { inherit host; })
    (import "${self}/deployments/grafana" { inherit host; })
  ];

  networking.hostName = "bespin";

  boot.loader.grub = {
    enable = true;
    efiSupport = false;
    devices = [ "/dev/sda" ];
  };

  system.stateVersion = "22.05";
}
