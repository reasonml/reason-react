# Contributing

Thanks for your interest! Below we describe reason-react development setup for the project.

```sh
git clone https://github.com/reasonml/reason-react.git
cd reason-react
```

## Installation

To set up a development environment using [opam](https://opam.ocaml.org/), run `make init` to set up an opam [local switch](https://opam.ocaml.org/blog/opam-local-switches/) and download the required dependencies.

## Developing

```sh
make dev ## Build in watch mode
make test ## Run the unit tests
```

Running `make help` you can see the common commands to interact with the project:

```sh
  build-prod      Build for production (--profile=prod)
  build           Build the project, including non installable libraries and executables
  clean           Clean artifacts
  create-switch   Create a local opam switch
  dev             Build in watch mode
  format-check    Checks if format is correct
  format          Format the codebase with ocamlformat
  help            Print this help message
  init            Create a local opam switch, install deps and pin dependencies
  install         Update the package dependencies when new deps are added to dune-project
  pin             Pin melange and dune
  test-promote    Updates snapshots and promotes it to correct
  test-watch      Run the unit tests in watch mode
  test            Run the unit tests
```

## Submitting a Pull Request

When you are almost ready to open a PR, it's a good idea to run the test suite locally to make sure everything works:

```sh
make test
```

If that all passes, then congratulations! You are well on your way to becoming a contributor 🎉
