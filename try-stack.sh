#!/usr/bin/env bash

if [ $# -ne 1 ]; then
  echo "expected 1 arg, RESOLVER"
  exit 1;
fi

set -euo pipefail
set -x

STACK_RESOLVER=$1

set -ex

dnf install -y curl

mkdir -p "root/.local/bin"
export PATH=root/.local/bin:$PATH

: "uname"
uname -a
: "ls -al"
ls -al /
: "id"
id
: "set"
set

: "try stack install"

curl -sSL https://get.haskellstack.org/ | sh

alias stack="stack --stack-root=/root/.stack"
stack setup
stack new foo hspec
cd foo; stack test

set +ex
