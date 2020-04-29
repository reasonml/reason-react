# [ReasonReact](https://reasonml.github.io/reason-react/)

ReasonML Bindings for [React.js](https://reactjs.org). Write the same React code you're used to, get your type system guarantees automatically!

ReasonReact uses ReactJS under the hood so you can easily integrate it into your Typescript or React.js project

[![Discorsd](https://img.shields.io/discord/235176658175262720.svg?logo=discord&colorb=blue)](https://discord.gg/reasonml)
[![npm version](https://badge.fury.io/js/reason-react.svg)](https://badge.fury.io/js/reason-react)
[![contributors](https://img.shields.io/github/contributors/reasonml/reason-react)]
[![twitter](https://img.shields.io/twitter/follow/reasonml?style=social)

## Example

```reason
/* Greeting.re */
[@react.component]
let make = (~name) => <h1> {React.string("Hello " ++ name)} </h1>
```

in another file:

```reason
ReactDOMRe.renderToElementWithId(<Greeting name="Taylor" />, "root");
```

For a more in-depth example, see: https://github.com/reasonml-community/reason-react-hacker-news

## Quick start

[BuckleScript](http://bucklescript.github.io/) compiles ReasonML code to JavaScript. You can get it with:

```sh
npm install --global bs-platform
bsb -init my-react-app -theme react-hooks
cd my-react-app && npm install && npm start
# in another tab
npm run server
```

## Documentation

See https://reasonml.github.io/reason-react/

## Contribute

```sh
git clone https://github.com/reasonml/reason-react.git
cd reason-react
npm install
npm start
```

Then add some files somewhere (don't forget to change `bsconfig.json`, if needed).

See the README inside `src` for more info!
