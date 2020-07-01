with (import <nixpkgs> {});

let
  rubyenv = bundlerEnv {
    name = "rb";
    # Setup for ruby gems using bundix generated gemset.nix
    ruby = ruby_2_7;
    gemfile = ./Gemfile;
    lockfile = ./Gemfile.lock;
    gemset = ./gemset.nix;
    # Bundler groups available in this environment
    groups = ["default" "development" "test"];
  };
in stdenv.mkDerivation {
  name = "phone-pals";
  version = "0.0.1";

  buildInputs = [
    stdenv
    git

    # Ruby deps
    ruby_2_7
    bundler
    bundix

    # Rails deps
    clang
    libxml2
    libxslt
    readline
    sqlite
    openssl
    nodejs
    yarn

    rubyenv
  ];

  shellHook = ''
    export LIBXML2_DIR=${pkgs.libxml2}
    export LIBXSLT_DIR=${pkgs.libxslt}
  '';
}
