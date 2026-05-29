#!/usr/bin/env bash
set -euo pipefail

# Push the closure of every flake check (for the current system) to Attic.
# Run after `nix flake check` so all outputs are realised.

system=$(nix eval --raw --impure --expr 'builtins.currentSystem')

mapfile -t checks < <(
  nix eval --json ".#checks.${system}" --apply builtins.attrNames | jq -r '.[]'
)

paths=()
for name in "${checks[@]}"; do
  paths+=(".#checks.${system}.${name}")
done

nix path-info --recursive "${paths[@]}" |
  grep -v '\.drv$' |
  xargs -r attic push invetica:invetica
