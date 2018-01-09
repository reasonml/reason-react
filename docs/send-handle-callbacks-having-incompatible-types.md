---
title: send/handle callbacks having Incompatible Types
---

You've probably passed `self.send` to a helper function that uses this `send` reference twice. For complex reasons this doesn't type; you'd have to pass in the whole `self` to the helper.
