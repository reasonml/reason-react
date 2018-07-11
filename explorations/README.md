
# `static-react`


This is an exploration of a Reason React API that tracks the shape of render
trees at the type system level.

This also includes a very minimal reference implementation of a reconciler on
these static tress, and a few tests cases that compile and execute natively.
It also relies on a new version of the jsx ppx which is also included in the
build.

This project is just an experiment to observe the trade-offs and benefits of
this type of API. We may take portions of this API and incrementally move them
into Reason React. If the fully statically typed API shown here were to be used
widely, it would still require a lot of hardening and testing.


## Install:
```
# After cloning
npm install -g esy
esy install
esy build
```

## Test

```
esy x ReactApp.exe
```

## Debugging PPX

You can debug what the jsx ppx transform is doing by seeing the post-transformed tree:
    ./_build/default/jsx/reactjs_jsx_ppx_v4.exe ./_build/default/bin/react-app/Main.re.ml ./out.txt
    esy refmt --parse binary --print re out.txt

# Overview:

A simplified React API and corresponding JSX data structure that opens up new
levels of safety and power, along with some major trade-offs. This React API is
simplified by using the Reason language features effectively. The types of
a rendered tree become a part of the component's type, and the structure of
rendered trees are static by default, but components may _explicitly_ opt into
certain regions being made dynamic.

The statically checked/enforced tree shape, allows a new set of APIs to be
expressed very safely, and allows for more efficient implementations of core
React integrations.

This document discusses these trade-offs.

## Pros:

**Use The Language: Simpler React Component API**

In this API, components are just curried functions. When you use JSX, you are
merely applying some of these curried arguments - up until the state argument.
Then, React fills in the final state argument with the most recent state. We
use language level default args to implement getInitialState.

    let render = (~propA, ~propB=default, children, ~state=propA+propB, self) => {
      Reducer(
        state,
        <div>
          <RenderTreeHere>
          </RenderTreeHere>
        </div>,
        myReducer
      );
    };

Stateless components are just functions that don't accept a final state.  This
is only viable when having a statically rigid React tree modeled and enforced
by the type system, and there is some unanswered questions about this.


    let render = (~propA, ~propB=default, children) => {
      <div>
        <RenderTreeHere>
        </RenderTreeHere>
      </div>
    };

Trees are static by default, which means they cannot dramatically change shape.
This component renders `div` with one child `RenderTreeHere`. It cannot, on
another render invocation begin to return a `div` with two children.  It
cannot, on another render invocation begin to implicitly return a `div` with a
single `<Typeahead />` component. That kind of dynamic switching must be
modeled explicitly with an API to be determined (something like wrapping in an
`Either`/`Or` variant):

      <div>
        {expr ? Either(<RenderTreeHere />) : Or(<Typeahead />)}
      </div>

If RenderTreeHere/Typeahead manage the same state type, and render the same tree shape, they don't even need to do an Either/Or wrapper; the state will be preserved across the transition of "component type".

Dynamic trees are possible, but must be explicitly modeled as such. (That API
is not implemented yet).

With this API, the following React APIs are unified into one single function.

  - `getInitialState`: Language level ~state=default satisfies this (it can refer to props).
  - `getDefaultProps`: Language level defaults address this.
  - `getDerivedStateFromProps`: The returning of `state` allows for this.
  - `extends React.Component`: Not needed.
  - `shouldComponentUpdate` (potentially - could add `self.prevElems : option(elems)` to `self`) \*

\* Per Sema's idea, we might be able to simply follow ComponentKit/Litho and not provide a `shouldComponentUpdate`. Benefits:
- If you need performance, might as well use `ref`. One fewer API to worry about.
- `sCU` is still a bit wonky with the props-as-arguments-and-not-data-structure paradigm. This is a good excuse not to provide the complexity.
- Many folks (dare we say the majority nowadays) use `sCU` improperly through misuse of e.g. immutable.js or ReactJS PureComponent. The literature on these matters are also super heavy for newcomers: wanna know how to optimize? First, learn the theory of immutability, blablabla.
- It's also possible that caching or incremental computation is a real alternative to `sCU`. Us recommending just the `ref` API, which by itself is already a suitable substitute, lets folks experiment with these in userland a little more.

**Unified JSX:**

A special data structure for holding JSX blocks is added along with this React
API to make it easier to safely compose components such that the types of the
trees are tracked at the type system level.

JSX elements use a special data type, but children are "not special". Whatever
you pass to components is what they receive as children. Multiple sequential
JSX such as `<a/> <b/>` are a "single unit" that carries their length `Two(a,
b)`. So when you call

    <C> <a/> <b/> </C>

you are actually passing the two elements `a` and `b` as a single unit `Two(a,
b)` for children. Single JSX children `<a/>` are recorded as `One(a)`, and are
of the same family of types as multiple children.

> The difference between one and two JSX children, is not like the difference
> between `23` and `[23, 44]`, which aren't even in the same type family. The
> difference between `One(a)` and `Two(a, b)` is more like the difference
> between `[23, 23]` and `[(23, 34), (23, 34)]` which are in the same type
> family (`list`).

If you want to express a sequence outside of JSX nesting, you just use `<>` to
make sure they are syntactically within a JSX region. The result of that is
equivalent to having specified those children inside of another JSX block.

For example, this:

    <C> <a/> <b/> <C/>

Is equivalent to:

    let children = <> <a/> <b/> </>;
    let result = <C> children <C/>;

> The `<> </>` doesn't add any wrapping. Fixed length sequences of JSX blocks
> are created merely by being *next* to each other as in `<a /> <b />`. It's
> just that in order to be syntactically "next to each other" they have to be
> inside another JSX syntax region. `<> </>` is just a syntactic region that
> allows multiple JSX items to exist - it has zero cost.


**There is no need for spread operator**

Because there is a JSX data structure that unifies individual JSX items, with
fixed length sets of JSX items, there is no need for the JSX spread operator.

  The following:

    <Button>...myChildren</Button>

  Can just be written as:

    <Button>myChildren</Button>

Regardless of if myChildren is a list of elements `<> <a/> <b/> </>` or a
single element `<div />`.


**Controllable Components On Demand:**

Since components are just partially applied functions waiting for React to
provide the state, all stateful components can be controllable by you as you
render them, temporarily or indefinitely. All you have to do is beat React to
specifying the state of the component, by partially applying the state argument
to the JSX element. Regular props are just partial application:

    <Input backgroundColor="black" />

And controlling the state of a component is just conceptually continuing that
partial application to its `~state` argument.

    <Input backgroundColor="black" ~state=forceThisState />

To make the types work out, you need to apply that `~state` argument via a call
to `React.control`. For example, from `bin/react-app/InputController.re`:

    let input = <Input init="initTxt" />;
    if (shouldControlInput) {
      React.control(input, ~state="haha I am controlling your input");
    } else {
      input
    }

> To prevent your component from being controlled, you can simply make the
> state abstract in its signature, and provide no public mechanism for
> operating on it.

**Enforcing Constraints On Children Shape:**

Components can statically verify that children are not passed to them for cases
where someone supplying children to you is likely a bug.

Components can statically ensure that only certain shapes are passed to them.
This is useful for some basic cases like "left/right" buttons that demand two
elements exactly, or ones that demand a single root component. Not all shapes
are easy to express though, in a usable manner. The important ones are though.

Components can statically ensure that only certain _kinds_ of components are
passed. So, only components that have internal state = `Button.state`. Thanks
to abstract types, this works even if `Button` keeps its state opaque.

**Safe Access To Instance Tree:**

Because the React tree is modeled statically, we now have safe access to the
items that you render. Refs are notoriously unsafe, and difficult to model with
static type systems.

The kind of access to rendered instances that this API allows is not full, and
is slightly difficult to use in its current form, but it is guaranteed to be
safe.

If you access a child instance:
- You are guaranteed it is present.
- You are guaranteed it is of the right type.
- You are guaranteed that your operations/reads on its state are statically
  checked.

> Note: It will take some more heavy integration work to expose this API on top
> of ReactJS today. The included reference implementation shows how it is very
> to implement safely if you have all the data available.

See `bin/react-app/RequestAnimationFrameComponent.re` for an example of safely
destructuring the rendered instance tree inside an "event" (reducer).

The current mechanism for doing this is pretty verbose (but it's never wrong!).
In this example, we get at the deep instance `d`.

      let TwoInstances(_, Instance({subtree: Instance(d)})) = inst.subtree;


- To prevent reading their public state, instances may be defined such that a
  portion of their state is kept private via type system.
- Once accessed, you may invoke custom methods on component instances.
- Note: To make this usable, we would need some custom combinators for
  getting at specific locations. For example to traverse from your main
  render return value to its first child, then to *that* component's third
  child, which should be a Button - and then to invoke a method on it, we
  could build some accessors such as:

      myInstance.subtree
      |> React.firstChild
      |> React.thirdChild
      |> Button.resetCount;

> Note: These accessors are not yet implemented, and it's not certain it is
> possible to build them (it is likely possible though.)

The safe access to rendered instances can be very helpful when implementing
animations, and/or when preparing to "control" a component's state (you often
want to read what its current state is before assuming control over that
state).


**Fewer Type Variables:**

The static tree React API may require fewer type variables that lead to type
generalization errors. This might change if the implementation becomes more
complex, or if this API is integrated with the current Reason React API.  It's
likely the case that the current Reason React API should exist regardless of if
the static-react API is adopted. Reason React's current dynamic/opaque types
are a great escape hatch.

**Polymorphic State:**

With static trees, you don't need to have these `createMake()` functions that
we occasionally need in Reason React today. See
`bin/react-app/PolymorphicState.re`.

## Cons:

**Not All Instances Will Be Exposed:**

When performing type safe reads of instances, not all instances will be
exposed. When you supply children to a component, they might not actually
render them. They will admit guarantees about what they render in their types,
but they might make those types abstract intentionally, in which case you
cannot read those instances - there's no guarantee that it exists.
Components will be able to admit that they _might_ render your instance, and
make that part of their public API in which case you'd need to handle the case
that it doesn't exist when destructuring the instance tree.


**You Must Opt Into Dynamic Switching:**

This might be a Pro in some cases, but it is more effort on the developer to
switch the general shape of the React tree. We can include lists/sequences that
grow/shrink dynamically, but those regions must be marked as such. Unbounded
growing sequences will likely need to be homogeneously typed (all be components
that manage the same type of `state`). Regions that switch between "either `<A
/>` or `<B />` will also need to be explicitly designated as performing a
dynamic switch between two branches, but the types of `A` and `B` may be
different.

There would also be a `<Sequence>` primitive abstraction that implements
growing/shrinking lists. One benefit of having static-by-default but
opt-into-dynamic-shapes, is that there is now no need for keys anywhere but
where you have opted into dynamicity.

**All Types Are Inferred. But They Are Large!**

The types of render trees grow large very quickly. Annotations are not
required, and so these types are inferred automatically (even polymorphic
components), but they blow up pretty quickly. Error messages will become
unreadable at some point unless components do something to make the types
smaller.


## Mitigating The Cons:

Those were some substantial drawbacks to this style of React API. The large
types may be the most problematic. We need to experiment with this API in
practice to see how large of an issue it really is but perhaps we can mitigate
the large types problem.

**Keeping Types Small:**

I've found a solution that mitigates the size of types exposed to interfaces,
while not requiring that developers write out those types in the
implementations. It can be implemented as a ppx, and would be generally useful
for any application - not just React based applications.

See [KEEPING_TYPES_SMALL.md](./KEEPING_TYPES_SMALL.md)


