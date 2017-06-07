__This documentation assumes relative familiarity with ReactJS.__

## Intro Examples

```reason
let component = ReasonReact.statefulComponent "Greeting";

let make ::name _children => {
  let handleClick _event state _self => ReasonReact.Update (state + 1);
  {
    ...component,
    initialState: fun () => 0,
    render: fun state self => {
      let greeting = "Hello " ^ name ^ ". You've clicked the button " ^ (string_of_int state) ^ " time(s)!";
      <button onClick=(self.update handleClick)> (ReasonReact.stringToElement greeting) </button>
    }
  }
};
```

## JSX

Reason comes with the [JSX](http://facebook.github.io/reason/#diving-deeper-jsx) syntax! Reason-React transforms it from an agnostic function call into a library-specific call though a macro. To take advantage of Reason-React JSX, put `{"reason": {"react-jsx": 2}"` in your [`bsconfig.json`](http://bloomberg.github.io/bucklescript/Manual.html#_bucklescript_build_system_code_bsb_code) (schema [here](http://bloomberg.github.io/bucklescript/docson/#build-schema.json)).

### Uncapitalized JSX

`<div foo=bar>child1 child2</div>` transforms to `ReactDOMRe.createElement "div" props::(ReactDOMRe.props foo::bar ()) [|child1, child2|]`, which compiles to the JS code `React.createElement('div', {foo: bar}, child1, child2)`.

Prop-less `<div />` transforms to `ReactDOMRe.createElement "div" [|child1, child2|]`, which compiles to `React.createElement('div', undefined, child1, child2)`.

### Capitalized JSX

`<MyReasonComponent key=a ref=b foo=bar>child1 child2</MyReasonComponent>` transforms to `ReasonReact.element key::a ref::b (MyReasonComponent.make foo::bar [|child1, child2|])`.

Prop-less `<MyReasonComponent />` transforms to `ReasonReact.element (MyReasonComponent.make [||])`.

## Component Creation

A component template is created through `ReasonReact.statefulComponent "ComponentName"` or `ReasonReact.statelessComponent "ComponentName"`. The latter is a convenience helper of the former, with the `state` type being pre-set to `()` (called "unit"). The string being passed is for debugging purposes (the equivalent of ReactJS' [`displayName`](https://facebook.github.io/react/docs/react-component.html#displayname)).

As an example, here's a `greeting.re` file's content:

```reason
let component = ReasonReact.statefulComponent "Greeting";
```

Now we'll define the function that's called when other files invoke `<Greeting name="John" />` (without JSX: `ReasonReact.element (Greeting.make name::"John" [||])`): the `make` function. It must return the component spec template we just defined, with functions such as `render` overridden:

```reason
let component = ReasonReact.statefulComponent "Greeting";
let make ::name _children => {
  ...component, /* spread the template's other defaults into here  */
  render: fun _state _self => <div> (ReasonReact.stringToElement name) </div>
};
```

**Note**: place `make` and `component` right beside each other! This helps readability and avoiding a corner-case type error for `state`.

## Accepting Props

Props are just the labeled arguments of the `make` function, seen above. They can also be optional and/or have defaults, e.g. `let make ::name ::age=? ::className="box" _children => ...`.

The last prop **must** be `children`. If you don't use it, simply ignore it by naming it `_` or `_children`. Names starting with underscore don't trigger compiler warnings if they're unused.
