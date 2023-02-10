---
title: We are rebranding to ReScript / React
---

BuckleScript & Reason are now called [ReScript](https://rescript-lang.org/blog/bucklescript-is-rebranding), therefore the **ReasonReact** bindings will now be known as **ReScript / React** and need to be moved to a different npm package.

This means...
- Our `reason-react` npm package will now be published as [`@rescript/react`](https://www.npmjs.com/package/@rescript/react)
- `rescript-react@0.10.1` is basically a cleaned up version of `reason-react@0.9.1` (see the [CHANGELOG](https://github.com/rescript-lang/rescript-react/blob/master/Changes.md#v0101) for minor breaking changes).
- The `reason-react` github repository will be archived. Please refer to our new repository at [github.com/rescript-lang/rescript-react](https://github.com/rescript-lang/rescript-react).
- The next upcoming `@rescript/react` release will come with a few cool new features! Check out our [RFC discussion](https://forum.rescript-lang.org/t/rfc-rescript-react/901) for more infos.

## Migration

From an API perspective, upgrading from `reason-react` to `@rescript/react` should be very easy, since most changes are a just matter of doing a few global search & replaces.
Details for the changed APIs can be found in our revamped [ReScript / React migration guide](https://rescript-lang.org/docs/react/latest/migrate-from-reason-react).

### Important: All Libraries need to be upgraded to `rescript/react`

Unfortunately `@rescript/react` based projects are not compatible with libraries that depend on the old `reason-react` package due to dependency conflicts.

In other words: If you try to compile a project that uses both, `@rescript/react` and `reason-react`, the compiler will not compile due to a `React` module name collision.

**There are currently three strategies to deal this issue:**

- As a temporary workaround, use a patching tool like [`npm patch-package`](https://www.npmjs.com/package/patch-package) to adjust the package dependencies of indidvidual bindings to `@rescript/react` (adapt `package.json` & `bsconfig.json`)
- Ask the maintainer of your outdated third-party library to create a new major version release with `@rescript/react` as a dependency (don't forget to mention which version supports `@rescript/react` in the README).
- Or as a third alternative, create an updated fork of the project, or copy the bindings directly in your ReScript project.
  - Also take the occasion to adapt `bs-` prefixed library names to our new [ReScript package conventions](https://rescript-lang.org/docs/guidelines/publishing-packages). Otherwise your new libraries will not show up on our [package index](https://rescript-lang.org/packages).

For more details on the name collision issue, please refer to [this forum post](https://forum.rescript-lang.org/t/discussion-reason-react-rescript-react-migration-path/1086).

We apologize for the inconvenience; we promise that the migration work will be worth it!

If you have any questions or migration issues, please open a discussion on the [ReScript Forum](https://forum.rescript-lang.org) to get support, or ping @ryyppy / @rickyvetter on Github.

Thanks for being part of the ReasonReact community and see you on the ReScript side!
