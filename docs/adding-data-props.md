---
title: Adding data-* attributes
---

DOM JSX accepts custom data attributes as camelCase props:

```reason
let element = <div className="item" dataTestId="item-42" dataState="ready" />;
```

The rendered element has `data-test-id="item-42"` and `data-state="ready"`.
This works on both HTML and SVG elements.

## Values

Data attribute values have type `string`. They can be literals or expressions:

```reason
let itemId = 42;
let element = <div dataItemId={Int.to_string(itemId)} />;
```

Pass an `option(string)` with `=?` to make an attribute optional. `Some(value)`
sets the attribute, and `None` omits it:

```reason
let render = (state: option(string)) => <div dataState=?state />;

let ready = render(Some("ready"));
let absent = render(None);
```

## Attribute names

Uppercase letters become lowercase, with hyphens at word boundaries. Acronyms
stay together, digits stay attached to the preceding word, and underscores are
preserved:

| JSX prop | DOM attribute |
| --- | --- |
| `dataTestId` | `data-test-id` |
| `dataURLPath` | `data-url-path` |
| `dataVersion2` | `data-version2` |
| `dataFoo_bar` | `data-foo_bar` |
| `dataFoo_Bar` | `data-foo_bar` |
| `dataFoo__bar` | `data-foo__bar` |
| `data_foo` | `data_foo` |
| `datafoo` | `datafoo` |

The standard `data` and `datatype` props keep their existing meanings. Other
props beginning with `data` follow the conversion above. Names containing
apostrophes are rejected because they are invalid DOM attribute names.

Each attribute name can occur only once on an element. Repeating a prop or
using two props that produce the same name is a compile-time error, even when
an optional value is `None`:

```reason
/* Rejected: both props render as data-url. */
let element = <div dataURL="first" dataUrl=?None />;
```

`dataFoo` and `data_foo` are distinct: they produce `data-foo` and `data_foo`.

## Component props

The name conversion applies to DOM elements. Props on your own components keep
their declared names and types. Convert values when forwarding them to the DOM:

```reason
module Item = {
  [@react.component]
  let make = (~dataId: int) => <div dataId={Int.to_string(dataId)} />;
};

let element = <Item dataId=42 />;
```

Ordinary DOM props such as `className`, `onClick`, and `ref` retain their usual
type checks when used alongside data attributes.
