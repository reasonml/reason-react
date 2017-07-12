Like HISTORY.md, but for planned future versions and subject to change. The vocabulary here uses the past tense, to pretend that the versions are already published.

# Far into the future

- Static tree (prevents top-level component switching, enables destructuring of owned tree).
- Getting rid of keys altogether in the common case.
- Getting rid of ref.
- Making a great list abstraction to model dynamically changing lists/scrollers.

# 0.2.4

- Added `defaultChecked` to DOM attribute (#29).
- Fix stateless components's `willReceiveProps`'s return value. It's now `unit` again.

- `enqueue`. Best thing ever.
- Secret (feature-that-must-not-be-named)
- remove create-react-class
- Set lifecycles to null when they do nothing. React skips over lifecycles that are set to null, we currently have wrappers around all of them, so things like didMount are enqueued for *every* component.
- `ReactDOMRe.createElement` (usually used through the JSX `<div> foo </div>`) has a new implementation that fixes an inadvertent children key warning in the previous version.
- either rename `willReceiveProps` to `propsReceived`, or keep the same name and make it take oldNew self bag
- better modeling for `stateless` and `retainedProps` from `unit` to something else
