---
title: Installation
---

ReasonReact is build to work with [Melange](https://melange.re/) and [Reason](https://reasonml.github.io/), this installation guide will help you get started.

If you want to build a new app or a new website with ReasonReact and Melange, we recommend to use a package manager such as [opam](https://opam.ocaml.org/) to download and install the required dependencies.

There are other alternatives available, such as [esy](https://esy.sh/) or [nix](https://nixos.org/) explained under [Melange documentation](https://melange.re/v1.0.0/getting-started/#alternative-package-managers-experimental) in better detail.

#### Requirements

- [melange](https://opam.ocaml.org/packages/melange) v1.0.0 or higher
- [dune](https://opam.ocaml.org/packages/dune/) v3.8.0 or higher

## Melange

Melange is the toolchain that compiles Reason and OCaml to JavaScript. It integrates with dune to provide a seamless experience for building and running your project.

Follow the getting started guide on [Melange's documentation](https://melange.re/v1.0.0/getting-started/) to continue.

## Editor Setup

Since Reason is an alternative syntax for OCaml, we integrate seamlessly into the official OCaml editor toolchain. Following the recommendation from [Melange's documentation](https://melange.re/v1.0.0/getting-started/#editor-integration).

- For VSCode, we recommend using the [vscode-ocaml-platform](https://github.com/ocamllabs/vscode-ocaml-platform) plugin
- For other editors (Emacs and Vim), we recommend using a language server client plugin of your choice, and pairing it with [ocaml-lsp](https://github.com/ocaml/ocaml-lsp).

### Using the template

[Melange opam template](https://github.com/melange-re/melange-opam-template) comes with the minimum required to build a ReasonReact application with all dependencies up-to-date and ready.

The `.re`/`.ml` files compile to straightforward `.js` files inside your `_build` folder. You can open `index.html` directly from the file system. No server needed! Change any file to see that page automatically refreshed.

```sh
# clone the repo
git clone https://github.com/melange-re/melange-opam-template my-reason-react-app

# This will initialise the opam switch and install all the dependencies (from both opam and npm)
cd my-reason-react-app && make init
# We install native dependencies (melange, dune, reason and reason-react) from opam
# while JavaScript dependencies (react, react-dom, webpack) from npm

# In separate terminals:
make watch # It will watch for changes in your Reason/OCaml files and compile them to JavaScript
make serve # Serves the application with a local HTTP server
```

Read more about the template in the [opam-template README](https://github.com/melange-re/melange-opam-template).

### Adding Reason to an existing React.js Project (Create React App, Next.js, etc.)

Set up manually is straight forward. Install native dependencies, add some scripts and create a `dune` file.

1. Install the following dependencies in your opam switch with

```sh
opam install melange dune reason reason-react reactjs-jsx-ppx -y
```

2. Enable melange inside dune under a `dune-project` file in the root of your project with the following:
```sh
(dune lang 3.8)
(using melange 0.1)
```

Check [dune docs](https://dune.readthedocs.io/en/latest/melange.html) for all fields available.

3. Create a `dune` file in the source of your Reason code with the following content:

```dune
(melange.emit
  (target melange) ; or any target name you want
  (libraries reason-react)
  (preprocess (pps reactjs-jsx-ppx)))
```

4. Run those commands to build your code:

```sh
# "@melange" is an alias created automatically from the target field in the dune file
opam exec -- dune build @melange
# or if you want to watch for changes
opam exec -- dune build @melange --watch
```

All compiled code will live under `_build/default/{{target_name}}` folder with the same structure as your source code.

## Next steps
Head to the [Intro example](intro-example.md) guide for a tour of the most important Reason React concepts you will encounter every day.
