# Reason-React

Reason-React is a safer, simpler way to build React components in [Reason](http://facebook.github.io/reason/).

It integrates deeply with language level features in order to create an expressive, statically typed API, packed into a tiny API surface area.

By binding directly to ReactJS, Reason-React gives you access to the entire React ecosystem, so that you can adopt it incrementally.

_This documentation assumes relative familiarity with ReactJS._

## Intro Examples

```reason
let component = ReasonReact.statefulComponent "Greeting";

let make ::name _children => {
  let click _event state _self => ReasonReact.Update (state + 1);
  {
    ...component,
    initialState: fun () => 0,
    render: fun state self => {
      let greeting = "Hello " ^ name ^ ". You've clicked the button " ^ (string_of_int state) ^ " time(s)!";
      <button onClick=(self.update click)> (ReasonReact.stringToElement greeting) </button>
    }
  }
};
```

## JSX

Reason comes with the [JSX](http://facebook.github.io/reason/#diving-deeper-jsx) syntax! Reason-React transforms it from an agnostic function call into a library-specific call though a macro. To take advantage of Reason-React JSX, put `{"reason": {"react-jsx": 2}"` in your [`bsconfig.json`](http://bloomberg.github.io/bucklescript/Manual.html#_bucklescript_build_system_code_bsb_code) (schema [here](http://bloomberg.github.io/bucklescript/docson/#build-schema.json)).

**Note** that due to current syntax constraints, you need to put spaces around the JSX children: `<div> foo </div>`.

### Uncapitalized

```reason
<div foo=bar> child1 child2 </div>
```

transforms into

```reason
ReactDOMRe.createElement "div" props::(ReactDOMRe.props foo::bar ()) [|child1, child2|]
```

which compiles to the JS code `React.createElement('div', {foo: bar}, child1, child2)`.

Prop-less `<div />` transforms to `ReactDOMRe.createElement "div" [|child1, child2|]`, which compiles to `React.createElement('div', undefined, child1, child2)`.

### Capitalized

```reason
<MyReasonComponent key=a ref=b foo=bar> child1 child2 </MyReasonComponent>
```

transforms to

```reason
ReasonReact.element key::a ref::b (MyReasonComponent.make foo::bar [|child1, child2|])
```

Prop-less `<MyReasonComponent />` transforms to `ReasonReact.element (MyReasonComponent.make [||])`.

## Component Creation

A component template is created through `ReasonReact.statelessComponent "ComponentName"`. The string being passed is for debugging purposes (the equivalent of ReactJS' [`displayName`](https://facebook.github.io/react/docs/react-component.html#displayname)).

As an example, here's a `greeting.re` file's content:

```reason
let component = ReasonReact.statelessComponent "Greeting";
```

Now we'll define the function that's called when other files invoke `<Greeting name="John" />` (without JSX: `ReasonReact.element (Greeting.make name::"John" [||])`): the `make` function. It must return the component spec template we just defined, with functions such as `render` overridden:

```reason
let component = ReasonReact.statelessComponent "Greeting";
let make ::name _children => {
  ...component, /* spread the template's other defaults into here  */
  render: fun () _self => <div> (ReasonReact.stringToElement name) </div>
};
```

**Note**: place `make` and `component` right beside each other! This helps readability and avoiding a corner-case type error for `state`.

### State

To turn a component stateful, use `ReasonReact.statefulComponent "ComponentName"` instead. Then, provide the `initialState` method. The state type you return **can be anything**!

```reason
let component = ReasonReact.statefulComponent "Greeting";
let make ::name _children => {
  ...component,
  initialState: fun () => 0, /* here, state is an `int` */
  render: fun state self => {
    let greeting = "Hello " ^ name ^ ". You've clicked the button " ^ (string_of_int state) ^ " time(s)!";
    <div> (ReasonReact.stringToElement greeting) </div>
  }
};
```

_As a matter of fact, `ReasonReact.statelessComponent` is just a convenience helper of `statefulComponent`, with the `state` type being pre-set to `()` (called "unit")_.

### Props

Props are just the labeled arguments of the `make` function, seen above. They can also be optional and/or have defaults, e.g. `let make ::name ::age=? ::className="box" _children => ...`.

The last prop **must** be `children`. If you don't use it, simply ignore it by naming it `_` or `_children`. Names starting with underscore don't trigger compiler warnings if they're unused.

### Render

`render` needs to return a `ReasonReact.reactElement`: `<div />`, `<MyComponent />`, `ReasonReact.nullElement` (the `null` you'd usually return, but this time of the `reactElement` type), etc. It takes in `state` (which is `()` for stateless components) and `self`, described below.

### `self`

`self` is a record that contains `update` and `handle`, used in conjunctions with callbacks props passed to components.

### Callback Handlers

In ReactJS, we can do `<div onClick={this.handleClick} />` and in `handleClick`, access the latest `props` and `state` (despite the callback being asynchronous) through `this.props` and `this.state`. We don't use `this` in Reason-React; to access the newest `props`, simply put the callbacks in `make`'s body and read its arguments. To access the newest `state`, wrap the callback with `self.update`!

```reason
let component = ...;
let make ::name _children => {
  let click _event state _self => ReasonReact.Update (state + 1); /* this state is guaranteed fresh */
  {
    ...component,
    initialState: ...,
    render: fun state self => {
      let greeting = ...;
      <button onClick=(self.update click)> (ReasonReact.stringToElement greeting) </button>
    }
  }
};
```

`update` expects a callback that:

- Accepts a payload, the newest state and `self`.
- Returns a `ReasonReact.update 'state`, aka either:
  - `ReasonReact.Update newStateToBeSet`: indicates the handler (e.g. `click`) wants to update the state (in ReactJS, it'd be an imperative `setState` call).
  - `ReasonReact.NoUpdate`: no state update.
  - `ReasonReact.SilentUpdate newStateToBeSet`: like `ReasonReact.Update`, but without triggering a re-render. Useful for `ref` and other instance variables, described later.

and `update` itself returns a function, the actual, ordinary callback passed to the component as prop. When the callback's invoked, `update` will in turn invoke the originally passed in handler, forwarding the payload, the up-to-date state, and `self`.

Often times, you'd return `NoUpdate` from the handler. For convenience, we've exposed a `self.handle`, which is just an `update` that doesn't expect a return value (aka expects just `unit`).

**Note**: sometimes you might be forwarding `update` or `handle` to some helpers. Pass the whole `self` instead and **annotate it**. This avoids a complex `self` record type behavior. See [Common Type Errors](common-type-errors). Example:

```reason
let click event state self => ...;

let renderItem self => {
  /* this needs to be self.ReasonReact.update, not self.update */
  <div onClick=(self.ReasonReact.update click)>
};

let make ::name _children => {
  ...component,
  render: fun state self => {
    let item = renderItem self;
    ...
  }
}
```

### Lifecycle Events

Reason-react supports the usuals:

```reason
willReceiveProps: state => self => state,
didMount: state => self => update state,
didUpdate: previousState::state => currentState::state => self => unit,
willUnmount: state => self => unit,
willUpdate: previousState::state => nextState::state => self => unit,
```

Note:

- We've dropped the `component` prefix from all these.
- `willReceiveProps` asks, for the return type, to be `state`, not `update state` (i.e. `NoUpdate/Update/SilentUpdate`). We presume you'd always want to update the state in this lifecycle.
- `didUpdate`, `willUnmount` and `willUpdate` don't allow you to return a new state to be updated, to prevent infinite loops.
- `didUpdate` and `willUpdate` are labeled now! This reduces confusion.
- `willMount` is unsupported. Use `didMount` instead.

### Instance Variables

A common pattern in ReactJS is to attach extra variables onto a component's spec:

```
const Greeting = React.createClass({
  intervalId: null,
  componentDidMount: () => this.intervalId = setInterval(...),
  render: ...
});
```

In reality, this is nothing but a thinly veiled way to mutate a component's "state", without triggering a re-render. Reason-React asks you to correctly put these instance variables into your component's `state`. To simulate updating the references without triggering a re-render, use `SilentUpdate`:

```reason
type state = {intervalId: option int, someOtherVar: option string};
let component = ...; /* remember, `component` needs to be close to `make`, and after `state` type declaration!
let make _children => {
  ...component,
  initialState: fun () => {intervalId: None, someOtherVar: Some "hello"},
  didMount: fun state _self => ReasonReact.SilentUpdate {...state, intervalId: Some (setInterval ...)},
  render: ...
};
```

### Ref

A `ref` would be just another instance variable. You'd type it as `ReasonReact.reactRef` if it's attached to a custom component, and `Dom.element` if it's attached to a React DOM element.

```reason
type state = {isOpen: bool, mySectionRef: option ReasonReact.reactRef};

let setSectionRef theRef state _self => ReasonReact.SilentUpdate {...state, mySectionRef: Some theRef};

let component = ReasonReact.statefulComponent "MyPanel";
let make ::className="" _children => {
  ...component,
  initialState: fun () => {isOpen: false, mySectionRef: None},
  render: fun state self => <Section1 ref=(self.update setSectionRef) />
};
```

Attaching to a React DOM element looks the same: `ReasonReact.SilentUpdate {...state, myDivRef: Js.Null.to_opt theRef}`. **Note** how [React DOM refs can be null](https://github.com/facebook/react/issues/9328#issuecomment-298438237). Which is why `myDivRef` is converted from a [JS nullable](http://bloomberg.github.io/bucklescript/Manual.html#_null_and_undefined) to an OCaml `option` (Some/None).

Reason-react ref only accept callbacks. The string `ref` from ReactJS is deprecated.

We also expose an escape hatch `ReasonReact.refToJsObj` (type: `ReasonReact.reactRef => Js.t {..}`) which turns your ref into a JS object you can freely use; **this is only used to access ReactJS component class methods**.

```reason
let handleClick event state self =>
  switch state.mySectionRef {
  | None => ()
  | Some r => (ReasonReact.refToJsObj r)##someMethod 1 2 3 /* I solemnly swear that I am up to no good */
  };
```

## Interop With Existing JavaScript Components

### ReasonReact using ReactJS

Easy! Since other Reason components only need you to expose a `make` function, fake one up:

```reason
external myJSReactClass : ReasonReact.reactClass = "myJSReactClass" [@@bs.module];

let make name::(name: string) age::(age: option int)=? children =>
  ReasonReact.wrapJsForReason
    reactClass::myJSReactClass
    props::{"name": name, "age": Js.Null_undefined.from_opt age}
    children;
```

`ReasonReact.wrapJsForReason` is the helper we expose for this purpose. It takes in the `reactClass` you want to wrap, the `props` js object (of type `Js.t {. foo: bar}`) you'd pass to it (with values converted from Reason data structures to JS), and the mandatory children you'd forward to the JS side.

**We recommend** to type the `make` parameters, since they're passed to `props` into the JS side, which is untyped.

### ReactJS Using ReasonReact

Eeeeasy. We expose a helper for the other direction, `ReasonReact.wrapReasonForJs`:

```reason
let component = ...;
let make ...;

let comp =
  ReasonReact.wrapReasonForJs
    ::component
    (fun jsProps => make name::jsProps##name age::?(Js.Null_undefined.to_opt jsProps##age) [||]);
```

The function takes in the labeled reason `component` you've created, and a function that, given the js props, asks you to call `make` while passing in the correctly converted parameters. You'd assign the whole thing to something like `comp`. The JS side can then import it:

```
var MyReasonComponent = require('myReasonComponent').comp;
// make sure you're passing the correct data types!
<MyReasonComponent name="John" />
```

## Events

Reason-React events map cleanly to ReactJS [synthetic events](https://facebook.github.io/react/docs/events.html). More info in the [inline docs](https://github.com/SanderSpies/react-on-reason/blob/380358e5894d4223e7dd9c1fb2df72f0756231bc/src/reactEventRe.rei#L1).

If you're accessing fields on your event object, like `event.target.value`, see [Working with DOM](#working-with-dom) below.

## Styles

Since CSS-in-JS is all the rage right now, we'll recommend our official pick soon. In the meantime, for inline styles, there's the `ReactDOMRe.Style.make` API:

```reason
<div style=(
  ReactDOMRe.Style.make
    color::"#444444"
    fontSize::"68px"
    ()
)/>
```

It's a labeled (typed!) function call that maps to the familiar style object `{color: '#444444', fontSize: '68px'}`. **Note** that `make` returns an opaque `ReactDOMRe.style` type that you can't read into. We also expose a `ReactDOMRe.Style.combine` that takes in two `style`s and combine them.

### Working with DOM

The `ReactDOMRe` module below exposes an unsafe `domElementToObj`. That's all you need.

## ReactDOM

Reason-react's equivalent `ReactDOMRe` exposes:

- `render : ReasonReact.reactElement => Dom.element => unit`

- `unmountComponentAtNode : Dom.element => unit`

- `findDOMNode : ReasonReact.reactRef => Dom.element`

- `objToDOMProps : Js.t {..} => reactDOMProps` (see use-case in [Invalid Prop Name](invalid-prop-name))

And two helpers:

- `domElementToObj : Dom.element => Js.t {..}`: turns a DOM element into a Js object whose fields that you can dangerously access: `(ReactDOMRe.domElementToObj (ReactEventRe.Form.target event))##value`.

- `renderToElementWithClassName : ReasonReact.reactElement => string => unit`: convenience. Finds the (first) element of the provided class name and `render` to it.

- `renderToElementWithId : ReasonReact.reactElement => string => unit`: convenience. Finds the element of the provided id and `render` to it.

## ReactDOMServer

Reason-react's equivalent `ReactDOMServerRe` exposes:

- `renderToString : ReactRe.reactElement => string`

- `renderToStaticMarkup : ReactRe.reactElement => string`

## Convert Over ReactJS Idioms

### Pass in Components Class as a Prop

In ReactJS, `<Menu banner=MyBanner />` is easy; in reason-react, we can't trivially pass the whole component module ([explanations](http://facebook.github.io/reason/modules.html#modules-basic-modules)). Solution:

```reason
<Menu bannerFunc=(fun prop1 prop2 => <MyBanner message=prop1 count=prop2 />) />
```

### Invalid Prop Name

Prop names like `type` (as in `<input type="text" />`) aren't syntactically valid; `type` is a reserved keyword in Reason/OCaml. Use `<input _type="text" />` instead. This follows BuckleScript's [name mangling rules](http://bloomberg.github.io/bucklescript/Manual.html#_object_label_translation_convention).

For `data-*` and `aria-*`, this is a bit trickier; You'd currently need to resort to using `ReactDOMRe.objToDOMProps` + the underlying desugared JSX call:

```reason
ReactDOMRe.createElement
  "li"
  props::(ReactDOMRe.objToDOMProps {"className": "foo", "aria-selected": true})
  [|child1, child2|]
```

For non-DOM components, you'd need to expose valid prop names.

## Miscellaneous

- Reason-React doesn't support ReactJS context (yet).
- No mixins.

## Common Type Errors

- `The type constructor state would escape its scope`: this probably means you've defined your `state` type _after_ `let component = ...`. Move it before the `let`.
- `Unbound record field update`/`Unbound record field handle`: this means you've passed `self` to a helper function of your render, and it used it like so: `<div onClick=(self.update click)/>`. This is because the record can't be found in the scope of the file. Just annotate it: `<div onClick=(self.ReasonReact.update click)/>`.
- Something about callbacks passed to `update` (or `handle`) having incompatible types between them: you've probably passed `self.update` to a helper function that uses this `update` reference twice. For complex reasons this doesn't type; you'd have to pass in the whole `self` to the helper.
