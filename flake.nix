{
  description = "Nix flake for xxd supporting wider columns";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        inputs.flake-parts.flakeModules.easyOverlay
      ];

      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];

      perSystem = {
        config,
        pkgs,
        ...
      }: {
        formatter = pkgs.alejandra;

        overlayAttrs = {
          inherit (config.packages) xxd;
        };

        packages = let
          xxd = pkgs.callPackage ./default.nix {};
        in {
          inherit xxd;
          default = xxd;
        };
      };
    };
}
