{
  description = "Tastefully appointed Nix flake templates.";

  outputs = _: {
    templates = let
      minimal = {
        path = ./minimal;
        description = "Flake dev shell with direnv — for libraries and tooling.";
      };
    in {
      default = minimal;
      inherit minimal;

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
