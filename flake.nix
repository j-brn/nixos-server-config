{
  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };
    deploy-rs = { url = "github:serokell/deploy-rs"; inputs.nixpkgs.follows = "nixpkgs"; };
    utils = { url = "github:numtide/flake-utils"; };
    agenix = { url = "github:ryantm/agenix"; inputs.nixpkgs.follows = "nixpkgs"; };
    arion = { url = "github:hercules-ci/arion"; inputs.nixpkgs.follows = "nixpkgs"; };
  };

  outputs = { self, nixpkgs, deploy-rs, utils, agenix, arion, ... }@inputs:
    {
      nixosConfigurations = {
        "kashyyyk" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs self; };
          modules = [
            agenix.nixosModule
            arion.nixosModules.arion
            ./default.nix
            ./hosts/kashyyyk/configuration.nix
          ];
        };

        "bespin" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs self; };
          modules = [
            agenix.nixosModule
            arion.nixosModules.arion
            ./default.nix
            ./hosts/bespin/configuration.nix
          ];
        };
      };

      deploy.nodes = {
        kashyyyk = {
          sshOpts = [ "-p" "222" ];
          hostname = "kashyyyk.bricker.io";
          fastConnection = true;

          profiles.system = {
            sshUser = "admin";
            path =
              deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.kashyyyk;
            user = "root";
          };
        };

        bespin = {
          sshOpts = [ "-p" "222" ];
          hostname = "bespin.bricker.io";
          fastConnection = true;

          profiles.system = {
            sshUser = "admin";
            path =
              deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.bespin;
            user = "root";
          };
        };
      };

      checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
    } // utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            agenix.defaultPackage.${system}
            deploy-rs.defaultPackage.${system}
            apacheHttpd
            nixpkgs-fmt
          ];
        };
      }
    );
}
