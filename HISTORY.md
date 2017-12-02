# 0.3.0

Technically a breaking change, but just because of the removal of a few deprecated things. **No migration script this time**; since the few breaking changes you encounter (if any) should have be spotted by the type system and fixed in a few secs anyway.

Improvements:

- **Loosen `children`'s restriction**. This unlocks _huge_ potentials. See the [blog post](https://reasonml.github.io/reason-react/blog/2017/11/17/power-children.html)!
- Fix a bug where side effects inside side effects were skipped (#98).
- React 16 support.
- All files upper-cased. This follows the [new community idiom](https://reasonml.github.io/guide/meta/project-structure#file-casing). Technically an internal change; doesn't affect your usage of ReasonReact.
- More DOM props. There are like, more DOM props added per year than the number of releases we have. What a funny time to be alive.

Breaking Changes:

- **`ref` is now typed as `Js.nullable(Dom.element)`, not `Js.null(Dom.element)`**. `Js.nullable` is the new community idiom from BuckleScript. Go through your codebase and change your `state.myRef := Js.Null.to_opt(theRef)` into `state.myRef := Js.Nullable.to_opt(theRef)`. We suggest you to also remove all mentions of `Js.null`, `Js.undefined`, `Js.Null` and `Js.Undefined`. `Js.Nullable` checks for both JavaScript `null` and `undefined`, thus making the JS interop more robust. In the past, people type certain values (especially js objects fields) as e.g. `null` and forget they can be `undefined`.
- DOM components (`ReactDOMRe`)'s `open`, `end` and `in` attributes are now changed to `_open`, `_end` and `_in` to avoid using reserved keywords. This is only breaking if you're using these attributes _and_ are on the old syntax.
- Remove old stuff: `enqueue`, `statefulComponent` and `self.update`. These have long been deprecated.

# 0.2.4

**Major update**, but again with **no** breaking changes, and _again_ with a convenience [migration script](https://github.com/reasonml/reason-react/blob/master/migrate/from02xTo024.js)! =)

The big change in this release is the deprecation of `statefulComponent` and `statefulComponentWithRetainedProps`. `statelessComponent` stays the same.

## Prerequisites

**Please first read the [blog post](https://reasonml.github.io/reason-react/blog.html#reducers-are-here)**.

**After** reading this migration guide, use the migration script (or not) like so: `node node_modules/reason-react/migrate/from02xTo024.js myReasonFile.re`.

## Migrate From StatefulComponent to ReducerComponent

There's no more need for `ReasonReact.statefulComponent`. Every state change is now controlled through a dedicated, centralized, react-fiber-ready, component-local mechanism called "reducer" (aka, the hype word for "state machine").

[Reason-react-example](https://github.com/reasonml-community/reason-react-example) is updated too. Go check the examples afterward!

In short:

- Replace all `ReasonReact.statefulComponent` with `ReasonReact.reducerComponent`.
- Replace e.g. `self.update handleClick` (where `handleClick` is `fun self => ReasonReact.Update {...self.state, foo: bar}`) with `self.reduce (fun _ => Click)`. `Click` is just a variant constructor you've defined. Let's call it "action".
- Add a `reducer` function to the body of your `...component` spread:

```reason
reducer: fun action state =>
  switch action {
  | Click => ReasonReact.Update {...state, foo: bar}
  }
```

We've also exposed new `ReasonReact.SideEffects` (aka `ReasonReact.NoUpdate`, with side-effect) and `ReasonReact.UpdateWithSideEffects` (`ReasonReact.Update` + side-effect).

The relevant section on actions, reducers and the new update additions are [in the main docs](https://reasonml.github.io/reason-react/#reason-react-component-creation-state-actions-reducer).

**If everything goes alright, we will be deprecating `statefulComponent` in the future**

## InstanceVars/React Ref Usage Changed

Before, we used to recommend using `ReasonReact.SilentUpdate` to deal with ReactJS' instance variables pattern (e.g. attaching properties onto the component class itself, like timer IDs, subscriptions, refs, etc.). Now we've moved to using a Reason `ref` cell (not the React ref, the [mutative Reason `ref`](https://reasonml.github.io/guide/language/mutation)). See the updated [instance variables section](https://reasonml.github.io/reason-react/#reason-react-component-creation-instance-variables).

The new recommendation also solves a corner-case bug with assigning more than one refs in the render.

## LifeCycle: Future `didMount` and `willReceiveProps` Signature Change

The future ReactJS Fiber in ReasonReact won't work well with lifecycle events that return the new state, aka:

- `didMount`'s `ReasonReact.Update {...state, foo: bar}`
- `willReceiveProps` `state`.

Please return `ReasonReact.NoUpdate` for the former (can't do much for the latter, `willReceiveProps`, for now. Keep it as it is). If you really need to trigger a state change, before the return, use a `self.reduce (fun () => Bar) ()`, aka immediately apply a reduce.

**We will make all lifecycles return `unit` in the future; it'll be an easy codemod to change `ReasonReact.NoUpdate` to nothing**.

## Miscellaneous Changes

- Add `defaultChecked`, `loop` and others to DOM attribute (#29, #37, #44, #50).
- Fix `cloneElement` binding (#49).
- Fix stateless components's `willReceiveProps`'s return value. It's now `unit` again.
- Fix wrong version of `retainedProps` in `willReceiveProps`.
- Remove the dependency on `create-react-class`. Now we're back to being dependency-free!
- Bump react/react-dom to 16.
- React/react-dom are now dependencies, rather than peerDependencies. This follows the Reason/BS idiom of making the bound library an implementation detail. NPM/Yarn will still dedupe multiple versions of react/react-dom correctly; no worries about that.

Enjoy!

# 0.2.1

Breaking update (sorry!)

**We've finally removed `ReactRe`**. It's been deprecated since 0.1.4. And we've offered a comprehensive migration in the 0.1.4 section below.

We've given folks a bit of breathing room in terms of breaking changes; now we're shipping another one, this time with a small migration script. **After installing reason-react**, use `node node_modules/reason-react/oldScriptCarefulMigrateFrom015To020.js myReasonFile.re`

- Instead of `fun state self => ...`, we've now rolled `state` into `self`, and now, you have `fun {state, handle} => ...`. The whole record is `self`. Feel free to destructure and get whatever you need!
- `self` now contains a new prop, `retainedProps`. This is a new (non-breaking) feature that solves the previous slightly inconvenient way of forwarding props to state, as described in the old API's lifecycle methods. Now there's a dedicated API for it! The docs describes this in detail.

# 0.1.5

Non-breaking update. Works better with bs-platform >=1.8.0, which comes with the following ReasonReact JSX fixes:

- JSX ppx now recursively transforms component's props.
- JSX ppx now reports the correct location for some errors.
- JSX ppx now correctly transforms some corner case with ref and key (`ref=?foo`).

Our own release contains the following improvements:

- Adjust ReactDOMRe's `props` and `style` to include more accurate DOM and style attributes and styles (#9, #15, #17).
- Add `ReactDOMRe.Style.unsafeAddProp` to unsafely add a prop to an existing `style`. Make sure you know what you're doing!
- Fix `reactRef`'s type in various locations. A React ref is actually always nullable; we've previously only acknowledged it for DOM ref, now we do for custom (composite) components ref too. A more detailed explanation is [here](https://github.com/facebook/react/issues/9328#issuecomment-298438237). This is documented in our docs in the ref section as well.
- Add `cloneElement` (solves adding otherwise invalid keys like aria-label and data-foo).
- Add `shouldUpdate`.

# 0.1.4

Major update! Though this is 100% backward compatible, so no major version bump. We've revamped the whole API based on all you awesome folks' feedback, and we've provided a gradual migration path.

## Requirements & Self-Congratulations
- New BuckleScript. bs-platform >=1.7.5
- This repo. reason-react >=0.1.4

Upon installing the new dependencies, **your existing code still works**. Isn't that great? You can incrementally convert things over. The old modules will stay around until the next or next next version. No rush!

`ReactDOMRe`, `ReactDOMServerRe` and `ReactEventRe` stay as-is. `ReactRe` is now deprecated (but again, is staying around) in favor of the new implementation, `ReasonReact`.

Small overview:

- No more modules/functors needed for the API (don't go crazy with the new function composition power please!)
- No more `include`
- 10-20% smaller code on average, both input and output
- Corner-cases with `children` and empty props mostly gone
- **Unused props now warn**

## Forwarded Definitions
The following definitions are carried over from `ReactRe` into `ReasonReact`, unchanged. A simple search-and-replace fixes all of them:

- `ReactRe.reactElement` -> `ReasonReact.reactElement`
- like wise, `reactClass`
- `reactRef`, `refToJsObj`
- `nullElement`, `stringToElement`, `arrayToElement`
- `createElement` (if you recall, this isn't the pervasive ReactJS `React.createElement`). It's only used raw in escape hatch situations. If you've never used it: great!

## JSX
Lowercase JSX `<div> whatever </div>` didn't change. Uppercase `<Foo ref=a key=b bar=baz> hello goodbye </Foo>` used to translate to `Foo.createElement ref::a key::b bar::baz [hello, goodbye]`. It now translates to `ReasonReact.element ref::a key::b (Foo.make bar::baz [|hello, goodbye|])`. We've pulled out `ref` and `key` into a dedicated call for good measures, and instead of using list as children, we now use array. More idiomatic ReactJS, list <-> array conversion churn.

To use the new JSX, change `bsconfig.json`'s `{"reason": {"react-jsx": true}}` to `{"reason": {"react-jsx": 2}}`. **Although you probably won't do that at the beginning**, since that'd change all JSX in the whole project and cause type errors everywhere. Instead, keep your old `bsconfig.json` unchanged and for the JSX you'd like to selectively convert over, put a `[@@@bs.config {jsx: 2}];` at the top of the file. Once you've converted everything over, switch to `{"react-jsx": 2}` in `bsconfig.json` and remove those `@@@bs.config` at the top of every file.

Alternatively, you can go straight to `{"react-jsx": 2}` in `bsconfig.json`, and put a `[@@@bs.config {jsx: 1}]` at the top of files where you'd like to use the old uppercase JSX transform.

**Before starting the sections below**, please briefly go through the new API on the documentation page.

## `Foo.createElement` (Jargon Change)
_Not to be confused with the `ReactRe.createElement` in the previous section_.

`Foo.createElement` is now referred to as `Foo.make`. `make` is a more idiomatic term in Reason/OCaml, and is shorter to type!

## `componentBag`
The concept of `componentBag` is now called `self`. We thought it'd be a more appropriate name. The new `self` doesn't contain `props`, `state`, `setState` and `instanceVars` anymore; these are no longer needed in the new ReasonReact.

### `componentBag.props`
Replaced with the new `make` (previously `createElement`) call which takes in labeled arguments. See more in [this section](https://reasonml.github.io/reason-react/#reason-react-component-creation-props).

How to access `props` in the `update`/`handle` callbacks now? You'd move these callback definitions into the `make` function body.

### `componentBag.state`
Now passed to you as an argument in callbacks and lifecyle events.

### `componentBag.instanceVars`
No longer needed. In ReactJS, attaching instance variables onto a component has always been a sly way of introducing 1. mutative state that 2. doesn't trigger re-render. This whole concept is now replaced by putting your value into `state` and using [`ReasonReact.SilentUpdate`](https://reasonml.github.io/reason-react/#reason-react-component-creation-callback-handlers) (doesn't trigger re-render, but does update state) in callbacks & lifecycles.

### `componentBag.setState`
Not to be confused with the ReactJS `setState` you often use (though if you're reading this migration guide, you probably know this already). This was an escape hatch designed for times when you can't, for example, return an `option state` from an `updater`, because you want to `setState` imperatively and asynchronously. The new idiom is to just use `self.update myhandler ()`. Notice `update myhandler` returns a callback just like before, but now you're immediately applying the callback.

### `updater`/`handler`
`updater` and `handler` are now called `update` and `handle`. They should be an easy search-and-replace.

The return type of `update`, instead of `option state`, is now `update state`.

The signature of the callback they take has changed. Instead of e.g. `updater (fun {props, state, instanceVars} event => Some {...state, foo: true})`, it's now `update (fun event state self => ReasonReact.Update {...state, foo: true})`. Formal, simplified type of the new callback: `payload => state => self => update state`.

`update` and `handle` don't memoize anymore; this reduces confusion and potential memory leaks.

## Render
`render`, previously in your component module, is now inside `make`. See the example [here](https://reasonml.github.io/reason-react/#reason-react-intro-examples).

## Ref & Other Mutable Instance Variables
`ref` now lives inside state, as described in `componentBag.instanceVars` just above. Instead of `componentBag.handler`+ mutating `instanceVars`, you'd now use `update` and returning `ReasonReact.SilentUpdate {...state, ref: theRef}`. `ref`s and others probably default to `None` in your initial state.

## Lifecycles

We've decided to finally drop the `component` prefix to lifecycle methods! `componentDidMount` is now just called `didMount`, etc. The signatures changed slightly; see them in the new [lifecycle events section](https://reasonml.github.io/reason-react/#reason-react-component-creation-lifecycle-events).

## Children
The children helpers & types `reactJsChildren`, `listToElement` and `jsChildrenToReason` are all gone from `ReasonReact`, since we now use array instead of list.

## New Reason <-> JS Interop

### `wrapPropsShamelessly` (Reason Calling JS)
It's not clear why we called it this way in the old API. Please tell @_chenglou that he should name things more seriously on a serious project. The new name is `wrapJsForReason`. The signature hasn't changed much; arguments are labeled now and explicitly accept an unlabeled `children` at the last position. Example:

Before:

```reason
external myJSReactClass : ReasonReact.reactClass = "myJSReactClass" [@@bs.module];

let createElement name::(name: string) age::(age: option int)=? =>
  ReactRe.wrapPropsShamelessly myJSReactClass {"name": name, "age": Js.Nullable.from_opt age};
```

After:

```reason
external myJSReactClass : ReasonReact.reactClass = "myJSReactClass" [@@bs.module];

let make name::(name: string) age::(age: option int)=? children =>
  ReasonReact.wrapJsForReason
    reactClass::myJSReactClass
    props::{"name": name, "age": Js.Nullable.from_opt age}
    children;
```

**Don't forget** that once these are converted over, the callsites of these components will need to use the new JSX transform described above. Otherwise they'll generate type errors.

### `jsPropsToReasonProps` (JS Calling Reason)
Now called `wrapReasonForJs`. The file-level `include` that served this interop is gone; it used to magically export the backing component `comp` for JS consumption. You now have to manually export `comp` through the new `wrapReasonForJs`. Continuation of the previous example:

```reason
let component = ...;
let make ...;

let comp =
  ReasonReact.wrapReasonForJs
    ::component
    (fun jsProps => make name::jsProps##name age::?(Js.Nullable.to_opt jsProps##age) [||]);
```

The function takes in the labeled reason `component`, and a function that, given the js props, asks you to call `make` while passing in the correctly converted parameters.

**Aaaand that's it**! Enjoy!

# 0.1.3
DOM ref is now typed as `Js.null Dom.element`, instead of just `Dom.element` (https://github.com/reasonml/reason-react/commit/6f2a75b). Trivial migration: https://github.com/reasonml-community/reason-react-example/commit/b44587a

# 0.1.2
Add `defaultValue` prop for input DOM component (https://github.com/reasonml/reason-react/commit/c293c6e)

# 0.1.1
Correct type of `dangerouslySetInnerHTML` (#76)

# 0.1.0
Lots of great people working together.
