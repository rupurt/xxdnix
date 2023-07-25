{
  pkgs,
  system,
  stdenv,
  colWidth ? "cols_1024",
}: let
  version = "25july23";
  patchFiles = {
    cols_1024 = ./1024_cols.patch;
    cols_768 = ./768_cols.patch;
    cols_512 = ./512_cols.patch;
    cols_384 = ./384_cols.patch;
  };
in
  stdenv.mkDerivation {
    pname = "xxd";
    inherit version;

    nativeBuildInputs = [pkgs.pkg-config];

    makeFlags = ["DESTDIR=${placeholder "out"}"];
    targetSharePath = "${placeholder "out"}/share";

    src = ./.;

    patches = [
      patchFiles.${colWidth}
    ];

    preInstall = ''
      mkdir -p $out/share
    '';

    checkPhase = ''
      xxd --version | grep ${version}
    '';
  }
