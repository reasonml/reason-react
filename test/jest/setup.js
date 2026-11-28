const {setImmediate, clearImmediate} = require("node:timers");

Object.assign(globalThis, {setImmediate, clearImmediate});
