{
  description = "Tastefully appointed Nix flake templates.";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    process-compose-flake.url = "github:Platonic-Systems/process-compose-flake";
    services-flake.url = "github:juspay/services-flake";
    treefmt-nix.url = "github:numtide/treefmt-nix";

    template-application = {
      url = "path:./application";
      inputs.flake-parts.follows = "flake-parts";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.process-compose-flake.follows = "process-compose-flake";
      inputs.services-flake.follows = "services-flake";
    };

    template-clojure = {
      url = "path:./clojure";
      inputs.flake-parts.follows = "flake-parts";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    template-minimal = {
      url = "path:./minimal";
      inputs.flake-parts.follows = "flake-parts";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {flake-parts, ...}: let
    minimalTmpl = {
      path = ./minimal;
      description = "Flake dev shell with direnv — for libraries and tooling.";
    };
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["aarch64-darwin" "x86_64-linux"];
      imports = [inputs.treefmt-nix.flakeModule];

      perSystem = {
        config,
        pkgs,
        system,
        ...
      }: {
        checks = {
          template-application = inputs.template-application.devShells.${system}.default;
          template-application-dev = inputs.template-application.packages.${system}.dev;
          template-clojure = inputs.template-clojure.devShells.${system}.default;
          template-minimal = inputs.template-minimal.devShells.${system}.default;
        };

        devShells.default = pkgs.mkShell {
          packages = [
            config.treefmt.build.wrapper
            pkgs.just
          ];
        };

        treefmt = {
          projectRootFile = "flake.nix";
          programs.alejandra.enable = true;
          programs.cljfmt.enable = true;
          programs.just.enable = true;
          programs.prettier.enable = true;
          programs.shfmt.enable = true;
        };
      };

      flake.templates = {
        default = minimalTmpl;
        minimal = minimalTmpl;

        application = {
          path = ./application;
          description = "Flake dev shell with process-compose and services — for runnable apps.";
        };

        clojure = {
          path = ./clojure;
          description = "Reloadable Clojure for Emacsen.";
        };
      };
    };
}
