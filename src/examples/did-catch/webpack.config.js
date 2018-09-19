var path = require("path");

module.exports = {
  mode: "development",
  entry: {
    "DidCatch.bundle": path.join(__dirname, "DidCatch.bs.js")
  },
  output: {
    path: __dirname
  }
};
