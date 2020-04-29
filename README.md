# [ReasonReact](https://reasonml.github.io/reason-react/)

[![npm version](https://badge.fury.io/js/reason-react.svg)](https://www.npmjs.com/package/reason-react)
![npm](https://img.shields.io/npm/dt/reason-react)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)
[![discord](https://img.shields.io/discord/235176658175262720.svg?logo=discord&colorb=blue)](https://discord.gg/reasonml)
[![contributors](https://img.shields.io/github/contributors/reasonml/reason-react)
[![twitter](https://img.shields.io/twitter/follow/reasonml?style=social)](https://twitter.com/reasonml)

ReasonML Bindings for [React.js](https://reactjs.org). ReasonReact is a safer, simpler way to build React components. You get a great type system with an even better developer experience. Learn more about ReasonReact & ReasonML [here](https://reasonml.github.io/reason-react/docs/en/what-and-why)

ReasonReact is just React.js under the hood. This makes it super easy to integrate with your current Next.js, Create React App, JavaScript, Flowtype or Typescript project. Learn more about getting started [here](https://reasonml.github.io/reason-react/docs/en/installation#adding-reason-to-an-existing-reactjs-project-create-react-app-nextjs-etc)

## Example

```reason
/* Greeting.re */

[@react.component]
let make = (~name) => <h1> {React.string("Hello " ++ name)} </h1>
```

See all of our examples [here](https://reasonml.github.io/reason-react/docs/en/simple). For a full application, check out [reason-react-hacker-news](https://github.com/reasonml-community/reason-react-hacker-news).

## Getting Started

[BuckleScript](http://bucklescript.github.io/) is how your ReasonML code gets compiled to Javascript. Every project that uses BuckleScript will have a `bsconfig.json` file (the same way you'd have tsconfig.json in a Typescript project) with project specific settings.

You can install BuckleScript globally or keep it project specific by adding it as a `devDependency`:

```sh
yarn global add bs-platform

# or npm
npm install --global bs-platform
```

If you install BuckleScript globally, you can quickly generate a ReasonReact project template (similar to `create-react-app`):

```sh
bsb -init my-react-app -theme react-hooks
cd my-react-app && npm install && npm start

# in another tab
npm run server
```

If you're interested in adding ReasonReact to your current project, it's a simple 2 step process:

```
yarn add bs-platform --dev --exact

# or npm
npm install bs-platform -D -S
```

Add the appropriate script tags to package.json:

```json
"scripts": {
  "re:build": "bsb -make-world -clean-world",
  "re:watch": "bsb -make-world -clean-world -w"
}
```

Copy the `bsconfig.json` file from our docs located [here](https://reasonml.github.io/reason-react/docs/en/installation#adding-reason-to-an-existing-reactjs-project-create-react-app-nextjs-etc)

## Documentation

See https://reasonml.github.io/reason-react/

## Contribute

We welcome all contributors! Anything from docs to issues to pull requests. Please help us :smile:

```sh
git clone https://github.com/reasonml/reason-react.git
cd reason-react
npm install
npm start
```

Then add some files somewhere (don't forget to change `bsconfig.json`, if needed).

See the README inside `src` for more info!
