_: {
  perSystem = {pkgs, ...}: {
    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        alejandra
        just
        prettier
        shfmt
        treefmt
      ];
    };
  };
}
