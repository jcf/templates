{pkgs, ...}: {
  claude.code.enable = true;

  packages = with pkgs; [
    alejandra
    prettier
    shfmt
    treefmt
  ];
}
