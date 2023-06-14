{
  pkgs,
  system,
  stdenv,
  ...
}: {
  pname ? "xxd",
  patch ? "cols_1024",
}: let
  version = "13jun03";
  patches = {
    cols_1024 = ./1024_cols.patch;
    cols_768 = ./768_cols.patch;
    cols_512 = ./512_cols.patch;
    cols_384 = ./384_cols.patch;
  };
in
stdenv.mkDerivation {
  pname = pname;
  version = version;

  nativeBuildInputs = [pkgs.pkg-config];

  makeFlags = ["DESTDIR=${placeholder "out"}"];
  targetSharePath = "${placeholder "out"}/share";

  src = ./.;
  patches = [
    patches.${patch}
  ];

  preInstall = ''
    mkdir -p $out/share
  '';

  checkPhase = ''
    xxd --version | grep ${version}
  '';
}
