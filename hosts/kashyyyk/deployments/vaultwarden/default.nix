{
  age.secrets.vaultwarden_env = {
    file = ../../../../secrets/vaultwarden.env.age;
    path = "/run/vaultwarden.env";
  };

  virtualisation.arion.projects.vaultwarden.settings = {
    imports = [
      ./arion-compose.nix
    ];
  };
}
