---
id: i-really-need-feature-x-from-reactjs
title: I Really Need Feature X From ReactJS
---

If you _really_ need whichever idiom we currently don't support in ReasonReact (after making sure that you indeed can't achieve it in current ReasonReact. P.S.you can ask us on [Discord](https://discord.gg/reasonml)), you can always write the component in ReactJS first, then bind to it using [our interop](interop.md). Try to isolate that functionality into a tiny ReactJS component and leave the rest in ReasonReact.

Then, fill an issue!
