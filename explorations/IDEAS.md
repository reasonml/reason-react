
```reason
<>
  <div>
    <span />
    <Button />
    <span />
  </div>
  <span />
</>
```

Could become:
```reason
Set_Two__Three__One_(div, span, Button.render, span, span)
<>
  <div className="hi">
    <span />
    <Button />
    <span />
  </div>
  <span />
</>
```

You may not be able to save anything if each needs to be partially applied. But you could in some cases.

In the above case you could allocate a single block:
```reason
Block(outerCount, 0, 0, innerCount, 0, 0, 0)
```

Evaluate the arguments to the first div, and populate the block, recording that
subsection's count in the block before those results. Now a pointer to the
header count of that section looks like a tuple. It can be passed to evaluate
the first div.
```reason
Block(outerCount, 0, 0, 3, <span/>, <Button/>, <span/>)
```

```reason
                             +----------------+
                             |                |
                             |                v
Block(2, <div className="hi"> </div>, <span>, 3, <span/>, <Button/>, <span/>)
```

Would need some special C block creation code to make sure that references to
the `3` will retain the whole block. Each offsetted reference to the block would
need an extra byte - stored as (pointer, offset).

So isn't that just where we started in terms of allocations?
