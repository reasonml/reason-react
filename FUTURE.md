Like HISTORY.md, but for planned future versions and subject to change. The vocabulary here uses the past tense, to pretend that the versions are already published.

# Far into the future

- Static tree (prevents top-level component switching, enables destructuring of owned tree).
- Getting rid of keys altogether in the common case.
- Getting rid of ref.
- Making a great list abstraction to model dynamically changing lists/scrollers.

# 0.2.1

- `enqueue`. Best thing ever.
- Secret (feature-that-must-not-be-named)
- remove create-react-class
- Set lifecycles to null when they do nothing. React skips over lifecycles that are set to null, we currently have wrappers around all of them, so things like didMount are enqueued for *every* component.

# 0.2.0

Breaking update (sorry!)

We've finally removed `ReactRe`. It's been deprecated since 0.1.4. And we've offered a comprehensive migration path below.

- Instead of `fun state self => ...`, we've now rolled `state` into `self`, and now, you have `fun {state, self} => ...`. Feel free to destructure and get whatever you need!
- `self` now contains a new prop, `retainedProps`. This is a new feature that solves the previous slightly inconvenient way of forwarding props to state, as described in the old API's lifecycle methods. Now there's a dedicated API for it! The docs describes this in detail.

- `ReactDOMRe.createElement` (usually used through the JSX `<div> foo </div>`) has a new implementation that fixes an inadvertent children key warning in the previous version.
- either rename `willReceiveProps` to `propsReceived`, or keep the same name and make it take oldNew self bag
