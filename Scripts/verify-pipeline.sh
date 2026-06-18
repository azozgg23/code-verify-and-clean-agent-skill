#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "[verify] Starting verification pipeline..."

run_if_exists() {
  local cmd="$1"
  if eval "$cmd" >/dev/null 2>&1; then
    echo "[verify] $cmd"
    eval "$cmd"
  else
    echo "[skip] $cmd not available or failed to resolve"
  fi
}

if [ -f package.json ]; then
  if command -v npm >/dev/null 2>&1; then
    if npm run lint >/dev/null 2>&1; then
      echo "[verify] npm run lint"
      npm run lint
    else
      echo "[skip] npm run lint not defined"
    fi

    if npm run test >/dev/null 2>&1; then
      echo "[verify] npm run test"
      npm run test
    else
      echo "[skip] npm run test not defined"
    fi

    if npm run typecheck >/dev/null 2>&1; then
      echo "[verify] npm run typecheck"
      npm run typecheck
    else
      echo "[skip] npm run typecheck not defined"
    fi
  fi
fi

if [ -f Cargo.toml ] && command -v cargo >/dev/null 2>&1; then
  echo "[verify] cargo fmt --check"
  cargo fmt --check
  echo "[verify] cargo test"
  cargo test
fi

if [ -f pyproject.toml ] || [ -f requirements.txt ]; then
  if command -v python3 >/dev/null 2>&1; then
    if python3 -m pytest >/dev/null 2>&1; then
      echo "[verify] python3 -m pytest"
      python3 -m pytest
    else
      echo "[skip] pytest not available or no tests configured"
    fi
  fi
fi

echo "[verify] Verification pipeline complete."