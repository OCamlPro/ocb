{ pkgs ? import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
  }) {}
}:

pkgs.mkShell {
  name = "ocb";
  dontDetectOcamlConflicts = true;
  nativeBuildInputs = with pkgs.ocaml-ng.ocamlPackages; [
    dune_3
    findlib
    ocaml
    ocamlformat
    odoc
  ];
  buildInputs = with pkgs.ocaml-ng.ocamlPackages; [
    cmdliner
    fmt
    prelude
  ];
}
