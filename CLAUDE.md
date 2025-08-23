# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

ReasonReact is a React binding library for ReasonML/OCaml that compiles to JavaScript via Melange. The project consists of:

- **Core library** (`src/`): React bindings including React, ReactDOM, ReactDOMServer, ReactDOMTestUtils
- **PPX preprocessor** (`ppx/`): JSX transformation and preprocessing for ReasonML/OCaml
- **Additional components**: ReasonReactRouter and ReasonReactErrorBoundary
- **Test suite**: Jest-based unit tests and dune snapshot tests

## Common Commands

### Development
```bash
make init           # Set up local opam switch and install dependencies
make dev            # Build in watch mode
make build          # Build the project
make build-prod     # Build for production
make clean          # Clean build artifacts
```

### Testing
```bash
make test           # Run dune snapshot tests
make test-watch     # Run tests in watch mode
make test-promote   # Update and promote test snapshots
npx jest           # Run Jest unit tests
npx jest --watch   # Run Jest tests in watch mode
```

### Code Quality
```bash
make format         # Format code with ocamlformat
make format-check   # Check if code is properly formatted
```

### Dependencies
```bash
make install        # Update opam and npm dependencies
```

## Project Structure

### Source Code (`src/`)
- **React.re/rei**: Core React bindings with hooks, components, events, and context
- **ReactDOM.re/rei**: DOM rendering and manipulation bindings
- **ReactDOMServer.re/rei**: Server-side rendering bindings
- **ReactDOMTestUtils.re/rei**: Testing utilities
- **ReasonReactRouter.re/rei**: Standalone routing component
- **ReasonReactErrorBoundary.re/rei**: Error boundary component

### PPX Preprocessor (`ppx/`)
- **reason_react_ppx.ml**: Main PPX implementation for JSX transformation
- **standalone.ml**: Standalone PPX executable
- **test/**: PPX transformation tests with `.t` files using dune cram testing

### Testing (`test/`)
- Jest-based unit tests for components and functionality
- Dune snapshot tests for PPX transformations
- Testing utilities in `jest/` subdirectory

## Development Workflow

1. Use `make init` for first-time setup (creates opam switch, installs deps)
2. Use `make dev` for active development with watch mode
3. Run `make test` before submitting PRs to ensure all tests pass
4. Use `make format` to maintain consistent code formatting
5. PPX tests use dune cram testing - run `make test-promote` to update snapshots

## Testing Strategy

- **Unit tests**: Jest-based tests in `test/` directory for component behavior
- **PPX tests**: Snapshot tests in `ppx/test/` using dune's cram testing framework
- **Integration**: Tests compile ReasonML to JavaScript and verify runtime behavior
- Test files follow pattern `*__test.re` for Jest and `*.t` for dune cram tests

## Build System

- **Dune 3.9+**: Primary build system with melange compilation target
- **Melange**: Compiles OCaml/ReasonML to JavaScript
- **Opam**: Package management for OCaml dependencies
- **NPM**: JavaScript dependency management (React, testing libraries)
- Build outputs target `_build/default/` directory structure