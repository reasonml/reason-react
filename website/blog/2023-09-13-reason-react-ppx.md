---
title: reason-react-ppx is on opam!
---

ReasonReact 0.12 provides the JSX transformation from `reason-react-ppx` (previously named `reactjs-jsx-ppx`) with a bunch of improvements.

The biggest changes are the new JSX transformation from React 17 and a great improvement on locations for props. A few bug fixes and some small breaking changes are also included (check below for more details).

### Locations from domProps in action (Thanks @jchavarri)
![download](https://github.com/reasonml/reason-react/assets/3763599/db505599-8fee-4889-80a3-d2056ece291c)

### new JSX transform (Thanks @anmonteiro)
<img width="1508" alt="Screenshot 2023-09-13 at 16 11 17" src="https://github.com/reasonml/reason-react/assets/3763599/b7fec116-131a-48cd-8be1-1496544131d1">

## What's changing?

Track `reacjs-jsx-ppx` in the same repository as `reason-react`, and rename it to `reason-react-ppx`, a more suitable name with a few improvements:
- Use the [new JSX transform](https://legacy.reactjs.org/blog/2020/09/22/introducing-the-new-jsx-transform.html) from React 17
- Fix code-generation locations for JSX and props
- Fix to allow memoCustomCompareProps
- Fix Type of optional prop not checked correctly in JSX
- The ppx will be synced with reason-react (and tested together)

## Updating to latest

To use ReasonReact, you must be using Melange. [Get started here](https://melange.re/v1.0.0/getting-started/).

Next:

- Update opam repository with `opam update`
- Install the latest versions: `opam install reason-react reason-react-ppx`
- In your dune file, add `reason-react` to `libraries` and `reason-react-ppx` to preprocess:

> (libraries reason-react)
> (preprocess (pps reason-react-ppx))

- Remove any usage of `ReactDOM.props`
- Bump React.js version to v17/v18 to use the new JSX transformation

## Future plans

- OCaml 5.1 + Melange v2
- Reason 3.10 support
- React 18 bindings
- Continue improving the state of the ppx (locations, avoid raising, etc..)
- Deprecate some legacy modules: `ReasonReact` and `ReactDOMRe`
- Work on interface files

Feel free to reach out if you have any feedback or want to get involved. You can [open an issue](https://github.com/reasonml/reason-react/issues) in this repository, or join the [ReasonML Discord](https://discord.gg/reasonml) and contact me (@davesnx) directly.

## Full changelog

Take a look at [reasonml/reason-react/releases/tag/0.12.0](https://github.com/reasonml/reason-react/releases/tag/0.12.0) for a full listing of all the changes.
