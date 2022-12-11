{
  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };
    deploy-rs = { url = "github:serokell/deploy-rs"; inputs.nixpkgs.follows = "nixpkgs"; };
    flake-parts.url = "github:hercules-ci/flake-parts";
    agenix = { url = "github:ryantm/agenix"; inputs.nixpkgs.follows = "nixpkgs"; };
    arion = { url = "github:hercules-ci/arion"; inputs.nixpkgs.follows = "nixpkgs"; };
  };

  outputs = { self, nixpkgs, deploy-rs, flake-parts, agenix, arion, ... }@inputs:
    flake-parts.lib.mkFlake { inherit self; } {
      flake = {
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

          "scarif" = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit inputs self; };
            modules = [
              agenix.nixosModule
              arion.nixosModules.arion
              ./default.nix
              ./hosts/scarif/configuration.nix
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

          scarif = {
            sshOpts = [ "-p" "222" ];
            hostname = "scarif.bricker.io";
            fastConnection = true;

            profiles.system = {
              sshUser = "admin";
              path =
                deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.scarif;
              user = "root";
            };
          };
        };
    };

    systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];

    perSystem = { pkgs, lib, system, config, ... }: {

      # shell script to get the hostkeys for all deployment hosts
      packages.keyscan = with lib; let
        commands = mapAttrsToList
          (_: node:
            let optStr = concatStringsSep " " ([ "-H" "-t ed25519" ] ++ node.sshOpts);
            in "ssh-keyscan ${optStr} ${node.hostname}")
          self.deploy.nodes;
      in
      pkgs.writeShellScriptBin "keyscan" (concatStringsSep "\n" commands);

      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          config.packages.keyscan
          agenix.defaultPackage.${system}
          pkgs.deploy-rs
          nixpkgs-fmt
        ];
      };

      checks = deploy-rs.lib.${system}.deployChecks self.deploy;
    };
  };
}
