Like HISTORY.md, but for planned future versions and subject to change. The vocabulary here uses the past tense, to pretend that the versions are already published.

# Medium/Long-term

- Static tree (prevents top-level component switching, enables destructuring of owned tree).
- Getting rid of ref.
- Making a great list abstraction to model dynamically changing lists/scrollers.
- Preparation for namespace
- Set lifecycles to null when they do nothing. React skips over lifecycles that are set to null, we currently have wrappers around all of them, so things like didMount are enqueued for *every* component.
- `ReactDOMRe.createElement` (usually used through the JSX `<div> foo </div>`) has a new implementation that fixes an inadvertent children key warning in the previous version.
- either rename `willReceiveProps` to `propsReceived`, or keep the same name and make it take oldNew self bag
- better modeling for `stateless` and `retainedProps` from `unit` to something else
- expose `ReasonReact.publicComponentSpec state retainedProps action` for less cryptic component type annotation.
- Get rid of implicit keys on a component (likely non-breaking)

# 0.4.0

**Requires** bs-platform `>=3.0.0`. Migration script coming soon.

## Breaking Changes

- Remove `SilentUpdate` and `SilentUpdateWithSideEffects`.
- `didMount` now returns `unit`.
- Remove `self.reduce` for real; use `self.send` (`reducer` is still around, of course).
- Remove `ReasonReact.Callback` module (undocumented and unused).

## Deprecations

- **Old `subscriptions` API is deprecated**. Please use the new `self.onUnmount`.
- `willReceiveProps` deprecated. We'll transition to React 16 very soon and release our binding to `deriveStateFromProps`.

## Improvements

- Use `bool` instead of `Js.boolean` (thanks to BuckleScript 3.0.0).
- Fix Router incompatibility with IE11 (#201).
- Much more streamlined internals.
- Prepare to transition to React 16.
