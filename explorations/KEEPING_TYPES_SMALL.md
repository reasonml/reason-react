You can imagine a syntax for the following objectives:

Avoid having to write out a long type:
--------------------------------------
```reason
[@hiders.makeTOpaque : '_some => t]
type t;
```

Generates:

```reason
external makeTOpaque :'_some => t = "%identity";
let makeTOpaque = (() => makeTOpaque)();
```



Avoid writing out long type parameters:
--------------------------------------
```reason
[@hiders.makeSubtreeOpaque : React.elem('_some) => React.elem(subtree)]
type subtree;
```

Generates:
```reason
external makeSubtreeOpaque : React.elem('_some) => React.elem(subtree) = "%identity";
let makeSubtreeOpaque = (() => makeSubtreeOpaque)();
```



Hide the fact that it is a list. Keeps the type param:
--------------------------------------
```reason
[@hiders.makeListOpaque : list('t) => subtree('t)]
type t('t);
```

Generates:
```reason
external makeListOpaque : list('a) => t('a) = "%identity";
```



Hide the fact that it's a list, and hides the type param:
--------------------------------------
```reason
[@hiders.makeListParamOpaque : list('_some) => t]
type t;
```

Generates:
```reason
external makeListParamOpaque : list('a) => t = "%identity";
let makeListParamOpaque = (() => makeListParamOpaque)();
```



Hides the fact that it is a Pair(list, _). Keeps the type param. Infers
part of the type:
--------------------------------------
```reason
[@hiders.inferPartOfT : Pair.t(list('a), '_some) => t('a)]
type t('a);
```

Generates: (THIS ONE WILL NOT WORK!)
```reason
external inferPartOfT : Pair.t(list('a), 'b) => t = "%identity";
let inferPartOfT = (() => inferPartOfT)();
```

There are two kinds of single quote type variables at play in the
external: One kind is one that we want to pose as '_a variables - they
should not realy be polymorphic, but we just don't want to write out the
types. The other kind really need to be polymorphic.
