---
id: reduce-handle-callbacks-having-incompatible-types
title: reduce/handle callbacks having Incompatible Types
---

You've probably passed `self.reduce` to a helper function that uses this `reduce` reference twice. For complex reasons this doesn't type; you'd have to pass in the whole `self` to the helper.
