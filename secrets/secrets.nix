let
  systems = {
    kashyyyk = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGWMlsz3XxFf42eyiit2pjHIK8AhLL1Lum34ZpYIx2OR";
  };
  users = {
    jonas = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG3eO5g2TPLcE3pzt/6XiGqGjbAeCr41s+5mSR0aZuHt";
  };
  allSystems = builtins.attrValues systems;
  allUsers = builtins.attrValues users;
in
{
}

