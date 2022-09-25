let
  kashyyyk = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGWMlsz3XxFf42eyiit2pjHIK8AhLL1Lum34ZpYIx2OR";
  bespin = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMe05LWn3z5bQ1lHEgJ2NmeW/bAA/GrLxDbSs2YL6mwA";
  jonas = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG3eO5g2TPLcE3pzt/6XiGqGjbAeCr41s+5mSR0aZuHt";

  allKeys = [ kashyyyk bespin jonas ];
in
{
  "bookstack.env.age".publicKeys = [ kashyyyk jonas ];
  "vaultwarden.env.age".publicKeys = [ kashyyyk jonas ];
  "prometheus.yml.age".publicKeys = [ bespin jonas ];
  "prometheus-auth.yml.age".publicKeys = [ bespin jonas ];
}

