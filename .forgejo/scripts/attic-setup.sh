#!/usr/bin/env bash
set -eu

usage() {
  echo >&2 "Usage: ATTIC_TOKEN=<token> attic-setup.sh"
}

if [[ -z ${ATTIC_TOKEN:-} ]]; then
  usage
  exit 22 # EINVAL
fi

# Configure auth for `attic push` only. Substituter for pulls is set
# system-wide via nix.settings, so `attic use` is intentionally omitted —
# it would warn about restricted nix.conf settings under an untrusted user
# and the system-level config already covers what it would add.
attic login invetica https://attic.lan.invetica.co.uk "$ATTIC_TOKEN"
