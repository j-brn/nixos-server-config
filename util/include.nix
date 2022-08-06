{ lib }: rec {
  includeDir = dirName:
    let
      toFilePath = name: value: dirName + ("/" + name);
      filterCaches = key: value: value == "regular" && lib.hasSuffix ".nix" key;
    in
    lib.mapAttrsToList toFilePath
      (lib.filterAttrs filterCaches (builtins.readDir dirName));
}
