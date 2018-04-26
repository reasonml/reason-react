---
title: Ternary Shortcut
---

ReactJS allows the pattern `showButton && <Button />`. While in this specific case, it's slightly shorter, in general, try not to do this in JS. In ReasonReact, you need to use `showButton ? <Button /> : ReasonReact.null`.
