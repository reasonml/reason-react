Like HISTORY.md, but for planned future versions and subject to change. The vocabulary here uses the past tense, to pretend that the versions are already published.

# 0.2.0

Breaking update (sorry!)

We've finally removed `ReactRe`. It's been deprecated since 0.1.4. And we've offered a comprehensive migration path below.

- Instead of `fun state self => ...`, we've now rolled `state` into `self`, and now, you have `fun {state, self} => ...`. Feel free to destructure and get whatever you need!
- This also means we don't need `ReasonReact.statelessComponent` anymore. The reasoning for adding it was just to avoid some confusing type errors when people use `statelessComponent` in conjunction with `fun state self => ...` rather than `fun () self => ...`.
- Secret (feature-that-must-not-be-named)

# 0.1.5

- Adjust ReactDOMRe's `props`; more accurate labels and types.
- Add `ReactDOMRe.Style.unsafeAddProp` to unsafely add a prop to an existing `style`. Make sure you know what you're doing!
- Fix `reactRef`'s type in various locations. A React ref is actually always nullable; we've previously only acknowledged it for DOM ref, now we do for custom (composite) components ref too. A more detailed explanation is [here](https://github.com/facebook/react/issues/9328#issuecomment-298438237). This is documented in our docs in the ref section as well.
- `self` now contains a new prop, `retainedProps`. This is a new feature that solves the previous slightly inconvenient way of forwarding props to state, as described in the old API's lifecycle methods. Now there's a dedicated API for it! The docs describes this in detail.
- `enqueue`. Best thing ever.
- `ReactDOMRe.createElement` (usually used through the JSX `<div> foo </div>`) has a new implementation that fixes an inadvertent children key warning in the previous version.

(Not in this repo, but ppx fixes that go into bs-platform)
- JSX ppx now recursively transforms component's props.
