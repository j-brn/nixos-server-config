{ self, config, pkgs, ... }:
let
  node-exporter-dashboard = pkgs.fetchurl {
    url = "https://gist.githubusercontent.com/j-brn/37c729bf627436e93103587305b4e7fa/raw/d8c1f8d8a82bb7a26b896229b032c73d3ae2c5d1/node-exporter.json";
    sha256 = "sha256-NqHzwFwobgFDZ+LPOVoeuOTnBXWxPduoNXU54P3i1lA=";
  };

  dashboardProvider = pkgs.writeText "default.yml"
    ''
      apiVersion: 1
      providers:
        - name: Default
          folder: Host Metrics
          type: file
          allowUiUpdates: false
          options:
            path: /etc/grafana/provisioning/dashboards/node-exporter.json
    '';
in
{
  age.secrets."grafana/prometheus-datasource.yml" = {
    file = "${self}/secrets/grafana/prometheus-datasource.yml.age";
    owner = "472";
  };

  virtualisation = {
    docker.ensureNetworks = [
      "proxy-network"
      "metrics"
    ];

    arion.projects.grafana.settings = {
      imports = [
        (import "${self}/deployments/grafana.nix" {
          host = "grafana.bricker.io";
          prometheusDatasourceFilePath = config.age.secrets."grafana/prometheus-datasource.yml".path;
          dashboardProviderFilePath = dashboardProvider;
          inherit node-exporter-dashboard;
        })
      ];
    };
  };
}
