#!/usr/bin/env bash

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

echo "========================================"
echo " Enterprise Linux Automation Preflight"
echo "========================================"

echo
echo "[1/5] YAML validation"
yamllint \
  inventories \
  playbooks \
  roles \
  execution-environment \
  collections \
  .github

echo
echo "[2/5] Ansible lint"
ansible-lint \
  playbooks \
  roles

echo
echo "[3/5] Playbook syntax validation"

for playbook in playbooks/*.yml; do
  echo "Checking: $playbook"

  ansible-playbook \
    --syntax-check \
    -i inventories/enterprise/inventory.yml \
    "$playbook"
done

echo
echo "[4/5] Secret-pattern validation"

if git grep -nE \
  'ghp_[A-Za-z0-9]+|github_pat_[A-Za-z0-9_]+|AKIA[0-9A-Z]{16}|BEGIN (RSA |EC |OPENSSH )?PRIVATE KEY'; then
  echo
  echo "ERROR: Potential secret material detected."
  exit 1
else
  echo "No prohibited secret patterns detected."
fi

echo
echo "[5/5] Generated EE context validation"

if git ls-files execution-environment/context | grep -q .; then
  echo "ERROR: Generated Ansible Builder context is tracked by Git."
  exit 1
fi

echo "Generated EE context is not tracked."

echo
echo "========================================"
echo " All preflight checks passed"
echo "========================================"
