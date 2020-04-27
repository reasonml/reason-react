---
title: GraphQL & Apollo
---

GraphQL and React play well together, and ReasonReact builds upon this
relationship. With
[`graphql-ppx`](https://github.com/reasonml-community/graphql_ppx), you can get
type-safe, compile-time validated GraphQL queries. This means that you don't
have to wait till runtime to see if your queries or mutations are typed
correctly! See the example below.

```reason
/* Username.re */

module UserQuery = [%graphql {|
  query UserQuery {
    currentUser {
      name
    }
  }
|}];
```

The `%graphql` name tells the compiler that a GraphQL query or mutation is
coming, and some extra compile-time logic should be run that validates what's
inside the `{|...|}` (multiline string syntax). In short, `graphql-ppx` will see
if the query/mutation you wrote is consistent with your defined
`graphql_schema.json`; if it's not, an error will be thrown by the compiler. See
the following invalid example:

```reason
/* Username.re */

module UserQuery = [%graphql {|
  query UserQuery {
    currentUser {
      namee // ERROR: Unknown field on type currentUser
    }
  }
|}];
```

Say goodbye to runtime GraphQL errors!

## Apollo Client

[Apollo Client](https://www.apollographql.com/docs/react/) is a well-known
GraphQL client for React. Fortunately,
[bindings](https://github.com/Astrocoders/reason-apollo-hooks) have been
produced to allow us to use Apollo within ReasonReact.

Let's see `graphql-ppx` and Apollo client in action. In the following example,
we're going to query for the `name` of the `currentUser`, just like before.
With Reason variants, we can handle each possible state in a readable and
idiomatic way, all the while knowing our `UserQuery` is valid.

The result is a React component that's (a) easy to reason about and (b)
completely type-safe (from a Reason and GraphQL perspective).

```reason
/* Username.re */

module UserQuery = [%graphql {|
  query UserQuery {
    currentUser {
      name
    }
  }
|}];

[@react.component]
let make = () => {
  let (currentUserName, _) = ApolloHooks.useQuery(UserQuery.definition);

  <div>
  {
    switch(currentUserName) {
      | Loading => <p>{React.string("Loading...")}</p>
      | Data(data) =>
        <p>{React.string(data##currentUser##name)}</p>
      | NoData
      | Error(_) => <p>{React.string("Get off my lawn!")}</p>
    }
  }
  </div>
}
```
