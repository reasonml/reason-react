---
title: We are rebranding to ReScript / React
---

BuckleScript & Reason are now called [ReScript](https://rescript-lang.org/blog/bucklescript-is-rebranding), which means that the **ReasonReact** bindings will now be known as **ReScript / React** and need to move to a different npm package.

This means...
- Our `reason-react` npm package will now be published as `@rescript/react`
- `reason-react@0.9.1` is almost equivalent to `rescript-react@0.10.1` (see the [CHANGELOG](https://github.com/rescript-lang/rescript-react/blob/master/Changes.md#v0101) for minor breaking changes).
- The `reason-react` github repository will be frozen. Please refer to our new repository at [github.com/rescript-lang/rescript-react](https://github.com/rescript-lang/rescript-react).
- The next upcoming `@rescript/react` release will come with a few cool new features! Check out our [RFC discussion](https://forum.rescript-lang.org/t/rfc-rescript-react/901) for more infos.

## Migration

The full migration guide can be found on our revamped [ReScript / React documentation](https://rescript-lang.org/docs/react/latest/migrate-from-reason-react).

### We Need Your Help!

In hindsight we realized that `@rescript/react` based projects are not compatible with libraries that depend on the old `reason-react` package.

In other words: If you try to compile a project that uses both, `@rescript/react` and `reason-react`, the compiler will not compile due to a `React` module name collision.

There are currently two strategies to deal this issue:

- Ask the maintainer of your outdated third-party library to create a new major version release with `@rescript/react` as a dependency (don't forget to mention which version supports `@rescript/react` in the README).
- Alternatively, create an updated fork of the project, or copy the bindings directly in your ReScript project.
- Also make sure to rename all `bs-` prefixed library names according to our [ReScript package conventions](https://rescript-lang.org/docs/guidelines/publishing-packages). Otherwise your new libraries will not show up on our [package index](https://rescript-lang.org/packages).


For more details on the name collision issue, please refer to [this forum post](https://forum.rescript-lang.org/t/discussion-reason-react-rescript-react-migration-path/1086).

We apologize for the inconvenience; we promise that the migration work will be worth it!

If you need have any questions, open a discussion on the [ReScript Forum](https://forum.rescript-lang.org), or ping @ryyppy / @rickyvetter on Github.

Thanks for being part of the ReasonReact community and see you on the ReScript side!
