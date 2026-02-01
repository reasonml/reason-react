
root_path=$PWD

bash "$(dirname "$0")/ppx.sh" "$@"

cd "$root_path"
