{
  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };
    deploy-rs = { url = "github:serokell/deploy-rs"; };
    agenix = { url = "github:ryantm/agenix"; };
  };

  outputs = { self, nixpkgs, deploy-rs, agenix, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        "kashyyyk" = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./default.nix
            ./hosts/kashyyyk/configuration.nix
          ];
        };
      };

      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          agenix.defaultPackage.${system}
          deploy-rs.defaultPackage.${system}
          nixpkgs-fmt
        ];
      };

      deploy.nodes = {
        kashyyyk = {
          sshOpts = [ "-p" "222" ];
          hostname = "kashyyyk.bricker.io";
          fastConnection = true;

          profiles.system = {
            sshUser = "admin";
            path =
              deploy-rs.lib.${system}.activate.nixos self.nixosConfigurations.kashyyyk;
            user = "root";
          };
        };
      };

      apps.x86_64-linux.deploy = {
        type = "app";
        program = "${deploy-rs.packages.${system}.default}/bin/deploy";
      };

      checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
    };
}
