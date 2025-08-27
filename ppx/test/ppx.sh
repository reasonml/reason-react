#!/bin/bash

set -eo pipefail

function usage() {
  echo "Usage: $(basename "$0") --output re [file.re]"
  echo "       $(basename "$0") --output ml [file.re]"
}

if [ -z "$3" ]; then
  usage
  exit
fi

refmt --parse re --print ml "$3" > output.ml
/home/me/external-repos/reason-react/_build/default/ppx/standalone.exe --impl output.ml -o temp.ml

if [ "$2" == "ml" ]; then
  cat temp.ml
  exit
elif [ "$2" == "re" ]; then
  refmt --parse ml --print re temp.ml
  exit
else
  usage
  exit
fi
