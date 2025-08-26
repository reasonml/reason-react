---
title: Adding data-* attributes
---

ReasonReact now supports data attributes directly in JSX with zero runtime overhead. Data attributes are transformed at compile-time for optimal performance.

## Direct JSX Support

You can now use `data_*` attributes directly in JSX:

```reason
[@react.component]
let make = () => {
  <div data_testid="my-component" data_cy="cypress-test" className="container">
    {React.string("Hello World")}
  </div>
};
```

This compiles to efficient code with proper `data-*` attribute names in the DOM:
```html
<div data-testid="my-component" data-cy="cypress-test" class="container">
  Hello World
</div>
```

## How It Works

The PPX automatically detects `data_*` attributes and:
1. **Transforms names**: `data_testid` becomes `data-testid` in the DOM
2. **Zero runtime overhead**: All transformation happens at compile-time  
3. **Backwards compatible**: Elements without data attributes use the standard path

## Examples

### Basic Usage
```reason
// Single data attribute
<button data_testid="submit-btn" onClick>
  {React.string("Submit")}
</button>

// Multiple data attributes  
<div data_testid="user-card" data_role="card" data_index="0">
  {React.string("User content")}
</div>
```

### Combined with Other Props
```reason
<input 
  data_testid="email-input"
  data_automation="login-form" 
  type_="email"
  className="form-input"
  placeholder="Enter email"
/>
```

### Backwards Compatibility
```reason
// Elements without data attributes work exactly as before
<div className="regular" id="normal">
  {React.string("No data attributes")}  
</div>
```

## Migration from Old Workarounds

If you were using the `Spread` component workaround:

### Before (Old Workaround)
```reason
<Spread props={"data-cy": "test"}>
  <div />
</Spread>
```

### After (Direct JSX)
```reason
<div data_cy="test" />
```

## Technical Details

- **Compile-time transformation**: No runtime performance impact
- **DOM elements only**: Works with `div`, `span`, `button`, etc. 
- **Automatic naming**: `data_testid` → `data-testid`, `data_user_id` → `data-user-id`
- **Type safe**: Compile-time validation of attribute syntax
