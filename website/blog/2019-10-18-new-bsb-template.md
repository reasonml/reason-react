---
title: New ReasonReact bsb template!
---

![New examples](/reason-react/img/new-bsb-template.png)

BuckleScript 6.2.1 just got released, and with it came a freshly updated bsb ReasonReact template. To try it, just use the [official installation](https://reasonml.github.io/reason-react/docs/en/installation#bucklescript): `bsb -init my-react-app -theme react-hooks`.

If you like what ReasonReact's Router did to your routing experience, you'll love what this template does to your project scaffolding. Highlights:

- **No more development-time bundler needed!**
  - Files are dynamically `require`d every page reload. **No caching, no stale bundle, no race condition**. Bsb provided us some much needed sanity in the build system. We're now applying the same philosophy to the subsequent bundling step at development time.
  - Thanks to that, the entire edit-reload cycle is now in milliseconds, with **cold** reloading. No state bugs.
  - An optional, example bundler (Webpack) for production is provided, just for completeness.
- **This starter boilerplate now serves the extra purpose of being a ReasonReact examples repo.**
  - Evergreen collection of use-cases right in your template. Supersedes the now-deprecated [reason-react-examples](https://github.com/reasonml-old/reason-react-example) repo.
  - Informative comments on possible, lean architecture choices. No decision paralysis.
  - **Table of ReasonReact features used** in the README, so that you can eye the ReasonReact API you need and directly jump into the corresponding file.
- **Finally, a front-end boilerplate you can 100% fit in your head!**
  - **Only two production dependencies**: React and ReasonReact.
  - **Only two development-time dependencies**: BuckleScript and moduleserve (the latter resolves the `require`s during development).
  - Simple, transparent and great for learners. Nothing in the repo is opaque; everything can be tweaked. You get to make structural changes as you see fit.

Ever seen newcomers subconsciously blame themselves for not understanding a boilerplate when it's too rigid or fragile? It hurts to watch that. Front-end boilerplate generators have become complex beasts that have exceed the threshold acceptable for learning. For us, a boilerplate needs to enable folks to:

- get to their first working screen quickly, and
- understand the entirely of what's going on. Hard to change what you don't understand!

Most boilerplates overfit the first, at the **huge expense** of the second. There are simply too many layers of shaky abstractions piled on top of each other for a person to truly grasp it; all the bells and whistles one might think newcomers appreciate pale in comparison to the disempowerment they'd feel facing such large scope and fragile setups. It shouldn't feel this elaborate to put pixels on the screen!

Such boilerplate is no way to design learnability. That's why ours keeps things at a minimum, and should ironically feel much easier to get started with and to fully grasp than the opposite, overbearing approach. We encourage you to go through every file in the project; they're well-commented, succinct, and immediately useful. It goes without saying that we did not compromise on the polish of the examples =).

For a long time, folks thought their edit-reload experience would be achieved through adding more layers on top of their bundler; we believe, just like for our ReasonReact Router, that we've achieved this by removing the layers.
