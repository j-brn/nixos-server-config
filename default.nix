{ pkgs, config, lib, ... }:
let
  utils = import ./util/include.nix { lib = lib; };
  imports =
    (utils.includeDir ./common) ++
    (utils.includeDir ./options) ++
    [
      ./overlay
    ];
in
{
  inherit imports;
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    settings = {
      substituters = [
        "https://cache.nixos.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
    };
  };
}
