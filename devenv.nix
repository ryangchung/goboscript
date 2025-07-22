{ pkgs, lib, config, inputs, ... }:

{
  languages = {
    shell.enable = true;
    nix.enable = true;
    rust.enable = true;
  };

  packages = [
    pkgs.git
    pkgs.rustc
    pkgs.cargo
  ];

  processes.cargo-watch.exec = "cargo-watch";

  enterShell = ''
    git --version
    gb-build() {
        echo "Building latest goboscript from source..."
        cargo install --path .
    }
    gb-build
  '';

  enterTest = ''
    echo "Running tests"
    git --version | grep --color=auto "${pkgs.git.version}"
  '';

  git-hooks.hooks = {
    nixpkgs-fmt.enable = true;
  };
}
