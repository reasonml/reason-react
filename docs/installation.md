---
id: installation
title: Installation
---

**Note**: for general Reason + BuckleScript editor setup, see [here](https://reasonml.github.io/guide/editor-tools/global-installation).

To easily try ReasonReact, we offer two solutions with different goals in mind.

## Bsb

Our preferred option in most cases. If it's your first time trying ReasonReact, feel free to use the more familiar create-react-app option below, too.

```sh
npm install -g bs-platform
bsb -init my-react-app -theme react
cd my-react-app && npm install && npm start
# in another tab
npm run webpack
```

BuckleScript's [bsb](https://bucklescript.github.io/docs/en/build-overview.html) build system has an `init` command that generates a project template. The `react` theme offers a lightweight solution optimized for low learning overhead and ease of integration into an existing project.

It compiles to straighfoward JS files, so you can open `index.html` directly from the file system. No server needed.

## Reason Scripts (Aka Create-React-App)

[Reason-scripts](https://github.com/reasonml-community/reason-scripts) provides a familiar experience to the ReactJS users who are already familiar with [create-react-app](https://github.com/facebookincubator/create-react-app). It's an all-encompassing solution. However, if it's too heavy for your taste, try the first option above (bsb).

As with `create-react-app`, `reason-scripts` comes with a server and hotloading built in.
