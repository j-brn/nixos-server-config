{
  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };
    deploy-rs = { url = "github:serokell/deploy-rs"; inputs.nixpkgs.follows = "nixpkgs"; };
    agenix = { url = "github:ryantm/agenix"; inputs.nixpkgs.follows = "nixpkgs"; };
    arion = { url = "github:hercules-ci/arion"; inputs.nixpkgs.follows = "nixpkgs"; };
  };

  outputs = { self, nixpkgs, deploy-rs, agenix, arion, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        "kashyyyk" = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs self; };
          modules = [
            agenix.nixosModule
            arion.nixosModules.arion
            ./default.nix
            ./hosts/kashyyyk/configuration.nix
          ];
        };

        "bespin" = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs self; };
          modules = [
            agenix.nixosModule
            arion.nixosModules.arion
            ./default.nix
            ./hosts/bespin/configuration.nix
          ];
        };
      };

      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          agenix.defaultPackage.${system}
          deploy-rs.defaultPackage.${system}
          apacheHttpd
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

        bespin = {
          sshOpts = [ "-p" "222" ];
          hostname = "bespin.bricker.io";
          fastConnection = true;

          profiles.system = {
            sshUser = "admin";
            path =
              deploy-rs.lib.${system}.activate.nixos self.nixosConfigurations.bespin;
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
