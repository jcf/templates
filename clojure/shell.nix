_: {
  perSystem = {pkgs, ...}: {
    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        alejandra
        babashka
        cljfmt
        clj-kondo
        clojure
        clojure-lsp
        just
        prettier
        shfmt
        treefmt
      ];
    };
  };
}
