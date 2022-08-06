{
  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };
    deploy-rs = { url = "github:serokell/deploy-rs"; };
  };

  outputs = { self, nixpkgs, deploy-rs, ... }: {
    nixosConfigurations = {
      "kashyyyk" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./default.nix
          ./hosts/kashyyyk/configuration.nix
        ];
      };
    };

    deploy.nodes = {
      kashyyyk = {
        sshOpts = [ "-p" "222" ];
        hostname = "142.132.168.168";
        fastConnection = true;

        profiles.system = {
          sshUser = "admin";
          path =
            deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.kashyyyk;
          user = "root";
        };
      };
    };

    apps.x86_64-linux.deploy = {
      type = "app";
      program = "${deploy-rs.packages.x86_64-linux.default}/bin/deploy";
    };

    checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
  };
}
