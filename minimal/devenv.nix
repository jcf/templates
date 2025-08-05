{pkgs, ...}: {
  claude.code.enable = true;

  packages = with pkgs; [
    prettier
    shfmt
    treefmt
  ];
}
