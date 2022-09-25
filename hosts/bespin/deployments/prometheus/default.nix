{
  age.secrets.prometheus_yml = {
    file = ../../../../secrets/prometheus.yml.age;
    path = "/run/prometheus.yml";
    owner = "nobody";
  };

  age.secrets.prometheus_auth_yml = {
    file = ../../../../secrets/prometheus-auth.yml.age;
    path = "/run/prometheus-auth.yml";
    owner = "nobody";
  };

  virtualisation.arion.projects.prometheus.settings = {
    imports = [
      ./arion-compose.nix
    ];
  };
}
