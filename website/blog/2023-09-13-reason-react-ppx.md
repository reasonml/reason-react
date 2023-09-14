---
title: `reason-react-ppx` is now on opam!
---

Today, we're releasing ReasonReact 0.12! The most important changes are renaming the JSX transform PPX from `reactjs-jsx-ppx` to `reason-react-ppx`, along with many other improvements:

- `reason-react-ppx` now emits the React 17 [JSX transform](https://legacy.reactjs.org/blog/2020/09/22/introducing-the-new-jsx-transform.html).
- Prop locations have been greatly improved, resulting in much better editor integration.
- Check the full changes below for more details around other fixes and small breaking changes.

### Locations from domProps in action (Thanks @jchavarri)
![download](https://github.com/reasonml/reason-react/assets/3763599/db505599-8fee-4889-80a3-d2056ece291c)

### new JSX transform (Thanks @anmonteiro)
<img width="1508" alt="Screenshot 2023-09-13 at 16 11 17" src="https://github.com/reasonml/reason-react/assets/3763599/b7fec116-131a-48cd-8be1-1496544131d1">

## What's changing?

Track `reacjs-jsx-ppx` in the same repository as `reason-react`, and rename it to `reason-react-ppx`, a more suitable name with a few improvements:
- Use the [new JSX transform](https://legacy.reactjs.org/blog/2020/09/22/introducing-the-new-jsx-transform.html) from React 17
- Fix code-generation locations for JSX and props
- Fix to allow using `React.memoCustomCompareProps`
- Fix Type of optional prop not checked correctly in JSX
- The ppx will be synced with reason-react (and tested together)

Take a look at [reasonml/reason-react/releases/tag/0.12.0](https://github.com/reasonml/reason-react/releases/tag/0.12.0) for a full listing of all the changes.

## Updating to latest

ReasonReact works best with Melange. [Get started here](https://melange.re/v1.0.0/getting-started/).

Next:

- Update the package definitions with `opam update`
- Install the latest versions: `opam install reason-react reason-react-ppx`
- In your dune file, add `reason-react` to `libraries` and `reason-react-ppx` to `preprocess`:

> (libraries reason-react)
> (preprocess (pps reason-react-ppx))

- Remove any usage of `ReactDOM.props`
- Bump React.js version to v17/v18 to use the new JSX transformation
- We added `depexts` in opam for `react` and `react-dom` to ensure you have the correct versions installed from npm. [`depexts`](https://opam.ocaml.org/packages/opam-depext/) is the mechanism by opam to ensure the correct versions of external dependencies are present, often used in OS development. @jchavarri created [the tool](https://github.com/jchavarri/opam-check-npm-deps) to ensure npm packages are present.
  ```clojure
    depexts: [
      ["react"] {npm-version = "^16.0.0 || ^17.0.0"}
      ["react-dom"] {npm-version = "^16.0.0 || ^17.0.0"}
    ]
  ```

## Future plans

- OCaml 5.1 + Melange v2
- Reason 3.10 support
- React 18 bindings
- Continue improving the state of the ppx (locations, avoid raising, etc..)
- Deprecate some legacy modules: `ReasonReact` and `ReactDOMRe`
- Work on interface files

Feel free to reach out if you have any feedback or want to get involved. You can [open an issue](https://github.com/reasonml/reason-react/issues) in this repository, or join the [ReasonML Discord](https://discord.gg/reasonml) and contact me (@davesnx) directly.
