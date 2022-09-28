{ self, pkgs, ... }:
let
  node-exporter-dashboard = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/rfmoz/grafana-dashboards/master/prometheus/node-exporter-full.json";
    sha256 = "sha256-T6eUIFIilVyuLOzHu1wztIfYvPkx5n0gk/GSgCHGsJc=";
  };
in
{
  virtualisation = {
    docker.ensureNetworks = [
      "proxy-network"
      "metrics"
    ];

    arion.projects.grafana.settings = {
      imports = [
        (import "${self}/deployments/grafana.nix" {
          host = "grafana.bricker.io";
          inherit node-exporter-dashboard;
        })
      ];
    };
  };
}
