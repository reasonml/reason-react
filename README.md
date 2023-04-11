> **Warning**
> For **ReScript** users, we recommend using [@rescript/react](https://github.com/rescript-lang/rescript-react) instead. Before, ReasonReact was designed to be used with BuckleScript and it got packaged into @rescript/react. More context on the move [here](https://rescript-lang.org/blog/bucklescript-is-rebranding).

# [ReasonReact](https://reasonml.github.io/reason-react/)

[![npm version](https://badge.fury.io/js/reason-react.svg)](https://www.npmjs.com/package/reason-react)
![npm](https://img.shields.io/npm/dt/reason-react)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)
![contributors](https://img.shields.io/github/contributors/reasonml/reason-react)
[![discord](https://img.shields.io/discord/235176658175262720.svg?logo=discord&colorb=blue)](https://discord.gg/reasonml)
[![twitter](https://img.shields.io/twitter/follow/reasonml?style=social)](https://twitter.com/reasonml)

ReasonReact is a safer, simpler way to build React components. You get a great type system with an even better developer experience. Why choose ReasonReact? Read more [here](https://reasonml.github.io/reason-react/docs/en/what-and-why)

ReasonReact is just React.js under the hood. This makes it super easy to integrate with your current Next.js, Create React App, JavaScript, Flowtype or TypeScript project. Learn more about getting started [here](https://reasonml.github.io/reason-react/docs/en/installation#adding-reason-to-an-existing-reactjs-project-create-react-app-nextjs-etc)

> Watch Ricky Vetter's Reason Conf talk, ["Why React is Just Better in Reason"](https://www.youtube.com/watch?v=i9Kr9wuz24g) to learn more about how Facebook & Messenger are using ReasonReact

> Watch Jordan Walke's Reason Conf talk, ["React to the Future"](https://www.youtube.com/watch?v=5fG_lyNuEAw) to learn more about the future of ReasonML and React

## Example

```reason
/* Greeting.re */

[@react.component]
let make = (~name) => <h1> {React.string("Hello " ++ name)} </h1>
```

See all of our examples [here](https://reasonml.github.io/reason-react/docs/en/simple). For a full application, check out [reason-react-hacker-news](https://github.com/reasonml-community/reason-react-hacker-news).

<!-- ## Getting Started -->

## Using Your Favorite Javascript Libraries

The same way that TypeScript has `type annotations`, we have `bindings`. Bindings are libraries that allow you to import a popular project (like lodash) or to import your own local file. ReasonReact is in fact an example of a binding!

## Documentation

See [https://reasonml.github.io/reason-react](https://reasonml.github.io/reason-react)

## Contribute

We welcome all contributors! Anything from docs to issues to pull requests. Please help us :smile:

[./CONTRIBUTING.md](./CONTRIBUTING.md)

## Editor Support

Looking for syntax highlighting for your favorite editor? Check out [ReasonML Editor Plugins](https://reasonml.github.io/docs/en/editor-plugins)
