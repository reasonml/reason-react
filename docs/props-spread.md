---
title: Props Spread
---

There is currently no story around doing this in a type-safe manner.

In some cases, props spreading can a big source of unpredictability and performance regression (think `shouldComponentUpdate`).

You can try either passing props down manually, or restructuring your components in a way that avoids the need for this.

If you need it for binding to existing ReactJS components, see [this section](clone-element.md).
