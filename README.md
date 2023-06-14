# xxdnix

Nix [flake](https://nixos.wiki/wiki/Flakes) for [xxd](https://manpages.org/xxd) supporting wider columns

- 384
- 512
- 768
- 1024 `[default]`

Based on [https://grail.eecs.csuohio.edu/~somos/xxd.c](https://grail.eecs.csuohio.edu/~somos/xxd.c)

### Option 1. Use the `xxd` CLI within your own flake

```nix
{
  inputs.nixpkgs.url = "github:nixos/nixpkgs";
  inputs.xxd.url = "github:rupurt/xxd";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    xxd,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            xxd.overlay
          ];
        };
      in rec
      {
        packages = {
          xxd = pkgs.xxd {};
        };

        devShells.default = pkgs.mkShell {
          packages = [
            packages.xxd
          ];
        };
      }
    );
}
```

The above config will add `xxd` to your dev shell and also allow you to execute it
through the `nix` CLI utilities.

```sh
# run from devshell
nix develop -c $SHELL
xxd --version
```

```sh
# run as application
nix run .#xxd -- --version
```

### Option 2. Run the `xxd` CLI directly with `nix run`

```nix
nix run github:rupurt/xxdnix -- --version
```

## Authors

- Alex Kwiatkowski - alex+git@fremantle.io

## License

`xxdnix` is released under the [MIT license](./LICENSE)
