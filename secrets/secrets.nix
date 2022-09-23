let
  kashyyyk = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGWMlsz3XxFf42eyiit2pjHIK8AhLL1Lum34ZpYIx2OR";
  jonas = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG3eO5g2TPLcE3pzt/6XiGqGjbAeCr41s+5mSR0aZuHt";

  allKeys = [ kashyyyk jonas ];
in
{
  "bookstack_database.env.age".publicKeys = allKeys;
}

