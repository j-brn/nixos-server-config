{
  age.secrets.vaultwarden_env = {
    file = ../../../../secrets/vaultwarden.env.age;
    path = "/run/vaultwarden.env";
  };

  virtualisation.docker.ensureNetworks = [ "proxy-network" ];

  virtualisation.arion.projects.vaultwarden.settings = {
    imports = [
      ./arion-compose.nix
    ];
  };
}
