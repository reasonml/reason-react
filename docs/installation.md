---
title: Installation
---

**Note**: for general Reason + BuckleScript editor setup, see [here](https://reasonml.github.io/docs/en/editor-plugins).

## BuckleScript

[BuckleScript](http://bucklescript.github.io/) compiles ReasonML code to JavaScript. You can get it with:

```sh
npm install --global bs-platform@6.2.1
bsb -init my-react-app -theme react-hooks
cd my-react-app && npm install && npm start
# in another tab
npm run server
```

BuckleScript's [bsb](https://bucklescript.github.io/docs/en/build-overview.html) build system has an `init` command that generates a project template. The `react-hooks` theme happens to be our official, lightweight template optimized for low learning overhead and ease of integration into an existing project.

The `.re` files compile to straightforward `.bs.js` files. You can open `index.html` directly from the file system. No server needed! Change any `.re` file to see that page automatically refreshed.

## Adding Reason + Bucklescript to an existing project

Install the following dependencies:

```sh
yarn add bs-platform --dev --exact
yarn add reason-react --exact
```

Add scripts to package.json:

```json
"scripts": {
  "re:build": "bsb -make-world -clean-world",
  "re:watch": "bsb -make-world -clean-world -w"
}
```

Create a bsconfig.json file in the root of your project with the following. You can change the name.

```json
{
  "name": "your-project-name",
  "reason": { "react-jsx": 3 },
  "bsc-flags": ["-bs-super-errors"],
  "sources": [
    {
      "dir": "src",
      "subdirs": true
    }
  ],
  "package-specs": [
    {
      "module": "es6",
      "in-source": true
    }
  ],
  "suffix": ".bs.js",
  "namespace": true,
  "bs-dependencies": [
    "reason-react"
  ],
  "ppx-flags": [],
  "refmt": 3
}
```
