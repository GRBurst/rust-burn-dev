{ pkgs ? import <nixpkgs> { } }:
let
  pname = "burn";
in
pkgs.mkShell {

  nativeBuildInputs = with pkgs; [
    pkg-config
    fontconfig
  ];

  buildInputs = with pkgs; [
    rustup

    vulkan-headers
    vulkan-loader
  ];

  shellHook = ''
    echo "--- Welcome to ${pname}! ---"
    projectDir=$PWD
    rustupHomeDir="$projectDir/.rustup"
    mkdir -p "$rustupHomeDir"

    export RUSTUP_HOME="$rustupHomeDir"

    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/.nix-profile/lib/:${pkgs.vulkan-loader}/lib"

    cargo fetch
  '';
}
