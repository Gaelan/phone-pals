{ pkgs ? import <nixpkgs> { }, env ? "development", masterKey ? null }:

let
  rubyenv = pkgs.bundlerEnv {
    name = "phone-pals-rubyenv";
    # Setup for ruby gems using bundix generated gemset.nix
    ruby = pkgs.ruby_2_7;
    gemfile = ./Gemfile;
    lockfile = ./Gemfile.lock;
    gemset = ./gemset.nix;
    # Bundler groups available in this environment
    groups = [ "default" env ];
  };
  nodeModules = pkgs.yarn2nix-moretea.mkYarnModules {
    name = "phone-pals-nodeModules";
    pname = "phone_pals";
    version = "0.1.0";
    packageJSON = ./package.json;
    yarnLock = ./yarn.lock;
    yarnNix = ./yarn.nix;
  };
in pkgs.stdenv.mkDerivation {
  name = "phone-pals";
  version = "0.0.1";

  src = pkgs.nix-gitignore.gitignoreSource [ ] ./.;

  buildInputs = with pkgs; [
    stdenv
    git

    # Ruby deps
    ruby_2_7
    bundler
    bundix

    # Node deps
    yarn2nix

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

  RAILS_ENV = env;
  RAILS_MASTER_KEY = masterKey;

  shellHook = ''
    export LIBXML2_DIR=${pkgs.libxml2}
    export LIBXSLT_DIR=${pkgs.libxslt}
  '';

  buildPhase = ''
    cp -r ${nodeModules}/node_modules node_modules

    rails yarn:disable assets:precompile

    rm -rf tmp
    ln -s /tmp/phonepals/tmp tmp
  '';

  installPhase = ''
    cp -r . $out
  '';

  passthru = { inherit rubyenv; };
}
