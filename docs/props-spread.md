---
id: props-spread
title: Props Spread
---

You can't. Props spreading is a big source of unpredictability and performance regression (think `shouldComponentUpdate`). Our API prevents this. If you reaaaaally need it for binding to existing ReactJS components, see [this section](clone-element.md).
