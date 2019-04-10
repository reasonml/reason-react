---
title: Router
---

ReasonReact comes with a router! We've leveraged the language and library features in order to create a router that's:

- The simplest, thinnest possible.
- Easily pluggable anywhere into your existing code.
- Performant and tiny.

[Here's the documented public interface](https://github.com/reasonml/reason-react/blob/master/src/ReasonReactRouter.rei), repeated here:

- `ReasonReactRouter.push(string)`: takes a new path and update the URL.
- `ReasonReactRouter.replace(string)`: like `push`, but replaces the current URL.
- `ReasonReactRouter.watchUrl(f)`: start watching for URL changes. Returns a subscription token. Upon url change, calls the callback and passes it the `ReasonReactRouter.url` record.
- `ReasonReactRouter.unwatchUrl(watcherID)`: stop watching for url changes.
- `ReasonReactRouter.dangerouslyGetInitialUrl()`: get `url` record outside of `watchUrl`. Described later.
- `ReasonReactRouter.useUrl(~serverUrl)`: only usable in the new [function component api](https://reasonml.github.io/docs/en/components).

## Match a Route

**There's no API**! `watchUrl` gives you back a `url` record of the following shape:

```reason
type url = {
  /* path takes window.location.pathname, like "/book/title/edit" and turns it into `["book", "title", "edit"]` */
  path: list(string),
  /* the url's hash, if any. The # symbol is stripped out for you */
  hash: string,
  /* the url's query params, if any. The ? symbol is stripped out for you */
  search: string
};
```

<aside class="warning">
The Record API is in feature-freeze. For the newest features and better support going forward, please consider migrating to the new <a href="https://reasonml.github.io/docs/en/components">function componenents</a>.
</aside>

So the url `www.hello.com/book/10/edit?name=Jane#author` is given back as:

```reason
{
  path: ["book", "10", "edit"],
  hash: "author",
  search: "name=Jane"
}
```

At this point, you can simply pattern match your way to glory!

```reason
let watcherID = ReasonReact.Router.watchUrl(url => {
  switch (url.path) {
  | ["book", id, "edit"] => handleBookEdit(id)
  | ["book", id] => getBook(id)
  | ["book", id, _] => noSuchBookOperation()
  | [] => showMainPage()
  | ["shop"] | ["shop", "index"] => showShoppingPage()
  | ["shop", ...rest] =>
     /* e.g. "shop/cart/10", but let "cart/10" be handled by another function */
    nestedMatch(rest)
  | _ => showNotFoundPage()
  }
});

/* some time later */
ReasonReact.Router.unwatchUrl(watcherID);
```

So you can match a path, match a subset of a path, defer part of a matching to a nested logic, etc.

### Tips & Tricks

Notice that this is just normal [pattern matching](https://reasonml.github.io/docs/en/pattern-matching.html). You can combine it with other features, such as tuple + ReasonReact features like [subscriptions](subscriptions-helper.md) and reducer:

```reason
let component = ReasonReact.reducerComponent("TodoApp");

let make = _children => {
  ...component,
  reducer: (action, state) =>
    switch (action) {
    /* router actions */
    | ShowAll => ReasonReact.Update({...state, nowShowing: AllTodos})
    | ShowActive => /* ... */
    /* todo actions */
    | ChangeTodo(text) => /* ... */
    },
  didMount: self => {
    let watcherID = ReasonReact.Router.watchUrl(url => {
      switch (url.hash, MyAppStatus.isUserLoggedIn) {
      | ("active", _) => self.send(ShowActive)
      | ("completed", _) => self.send(ShowCompleted)
      | ("shared", true) => self.send(ShowShared)
      | ("shared", false) when isSpecialUser => /* handle this state please */
      | ("shared", false) => /* handle this state please */
      | _ => self.send(ShowAll)
      }
    });
    self.onUnmount(() => ReasonReact.Router.unwatchUrl(watcherID));
  },
  render: ...
}
```

## Directly Get a Route

In one specific occasion, you might want to take hold of a `url` record _outside_ of `watchUrl`. For example, if you've put `watchUrl` inside a component's `didMount` so that a URL change triggers a component state change, you might also want the initial state to be dictated by the URL.

In other words, you'd like to read from the `url` record once at the beginning of your app logic. We expose `dangerouslyGetInitialUrl()` for this purpose.

**Note**: the reason why we label it as "dangerous" is to remind you **not** to read this `url` in any arbitrary component's e.g. `render`, since that information might be out of date if said component doesn't also contain a `watchUrl` subscription that re-renders the component when the URL changes. Aka, please only use `dangerouslyGetInitialUrl` alongside `watchUrl`.

## Push a New Route

From anywhere in your app, just call e.g. `ReasonReact.Router.push("/books/10/edit#validated")`. This will trigger a URL change (without a page refresh) and `watchUrl`'s callback will be called again.

We might provide better facilities for typed routing + payload carrying in the future!

**Note**: because of browser limitations, changing the URL through JavaScript (aka `pushState`) **cannot** be detected. The solution is to change the URL then fire a `"popState"` event. This is what `Router.push` does, and what the event `watchUrl` listens to. So if, for whatever reason (e.g. incremental migration), you want to update the URL outside of `Router.push`, just do `window.dispatchEvent(new Event('popState'))`.

## Design Decisions

We always strive to lower the performance and learning overhead in ReasonReact, and our router design's no different. The entire implementation, barring browser features detection, is around 20 lines. The design might seem obvious in retrospect, but to arrive here, we had to dig back into ReactJS internals & future proposals to make sure we understood the state update mechanisms, the future context proposal, lifecycle ordering, etc. and reject some bad API designs along the way. It's nice to arrive at such an obvious solution!

The API also doesn't dictate whether matching on a route should return a component, a state update, or a side-effect. Flexible enough to slip into existing apps.

Performance-wise, a JavaScript-like API tends to use a JS object of route string -> callback. We eschewed that in favor of pattern-matching, since the latter in Reason does not allocate memory, and is compiled to a fast jump table in C++ (through the JS JIT). In fact, the only allocation in the router matching is the creation of the `url` record!
