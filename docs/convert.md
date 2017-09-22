---
id: convert
title: Convert Over ReactJS Idioms
---
### Pass in Components Class as a Prop

In ReactJS, `<Menu banner=MyBanner />` is easy; in ReasonReact, we can't trivially pass the whole component module ([explanations](https://reasonml.github.io/guide/language/module)). Solution:

```reason
let bannerCallback prop1 prop2 => <MyBanner message=prop1 count=prop2 />;
<Menu bannerFunc=bannerCallback />
```

### Invalid Prop Name

Prop names like `type` (as in `<input type="text" />`) aren't syntactically valid; `type` is a reserved keyword in Reason/OCaml. Use `<input _type="text" />` instead. This follows BuckleScript's [name mangling rules](http://bucklescript.github.io/bucklescript/Manual.html#_object_label_translation_convention).

For `data-*` and `aria-*`, this is a bit trickier; these props aren't actually syntactically valid when you write `<div aria-label="click me" />`. See [`cloneElement`](#reason-react-cloneelement) above for the workaround. For non-DOM components, you need to use valid prop names.

### Props spread

Since ReasonReact props are just function arguments, you can't achieve the ReactJS prop spread. The JSX argument punning lessen the visual burden here.

Generally speaking, prop spread is discouraged; it can be unpredictable, slow and too meta. However, you can still use [`cloneElement`](#reason-react-cloneelement) to achieve this in ReasonReact by passing the extra props to `cloneElement`'s labelled `props` argument.

### Boolean Shortcut

ReactJS allows the pattern `showButton && <Button />`. While in this specific case, it's usually not too harmful, in general, try not to do this. In ReasonReact, you use `showButton ? <Button /> : ReasonReact.nullElement`.

### Functional Component

You can use a function as a component in ReactJS. In ReasonReact, this is not yet possible (soon!); though you can obviously just call the function without using the JSX syntax: `MyList.make className::"foo" [||]`.
