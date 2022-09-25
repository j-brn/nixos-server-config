{
  age.secrets.bookstack_database = {
    file = ../../../../secrets/bookstack.env.age;
    path = "/run/bookstack.env";
  };

  virtualisation.arion.projects.bookstack.settings = {
    imports = [
      ./arion-compose.nix
    ];
  };
}
