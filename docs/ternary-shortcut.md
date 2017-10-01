---
id: ternary-shortcut
title: Ternary Shortcut
---

ReactJS allows the pattern `showButton && <Button />`. While in this specific case, it's usually not too harmful, in general, try not to do this. In ReasonReact, you use `showButton ? <Button /> : ReasonReact.nullElement`.
