#!/bin/bash

set -eo pipefail

if [ -z "$1" ]; then
  echo "Usage: $(basename "$0") [file.re]"
  exit
fi

refmt --parse re --print ml "$1" > output.ml
reason-react-ppx --impl output.ml -o temp.ml
cat temp.ml
