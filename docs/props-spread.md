---
id: props-spread
title: How do I do props spreading?
---
You can't. Props spreading is a big source of unpredictability and performance regression (think `shouldComponentUpdate`). Our API prevents this. If you reaaaaally need it for interop, see [this section](/index.html#reason-react-convert-over-reactjs-idioms-props-spread).
