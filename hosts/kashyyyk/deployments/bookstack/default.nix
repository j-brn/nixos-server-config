{
  age.secrets.bookstack_database = {
    file = ../../../../secrets/bookstack_database.env.age;
    path = "/run/bookstack_database.env";
  };

  virtualisation.arion.projects.bookstack.settings = {
    imports = [
      ./arion-compose.nix
    ];
  };
}