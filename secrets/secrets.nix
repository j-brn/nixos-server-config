let
  kashyyyk = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGWMlsz3XxFf42eyiit2pjHIK8AhLL1Lum34ZpYIx2OR";
  bespin = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMe05LWn3z5bQ1lHEgJ2NmeW/bAA/GrLxDbSs2YL6mwA";
  scarif = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM7ovgF1Km6wcpVCyMzpYl0QzDJluNVAErNyziGFa7X0";
  jonas = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG3eO5g2TPLcE3pzt/6XiGqGjbAeCr41s+5mSR0aZuHt";

  allKeys = [ kashyyyk bespin scarif jonas ];
in
{
  # node-exporter
  "node-exporter/auth.yml.age".publicKeys = allKeys;

  # cadvisor
  "cadvisor/htpasswd.age".publicKeys = allKeys;

  # bookstack
  "bookstack/environment.env.age".publicKeys = [ kashyyyk jonas ];

  # vaultwarden
  "vaultwarden/environment.env.age".publicKeys = [ kashyyyk jonas ];

  # prometheus
  "prometheus/prometheus.yml.age".publicKeys = [ bespin jonas ];
  "prometheus/auth.yml.age".publicKeys = [ bespin jonas ];

  # grafana
  "grafana/prometheus-datasource.yml.age".publicKeys = [ bespin jonas ];

  # garrysmod
  "garrysmod/secret-environment.env.age".publicKeys = [ scarif jonas ];
}

