var path = require("path");

module.exports = {
  mode: "development",
  entry: {
    "DidCatchAlternativeSyntax.bundle": path.join(
      __dirname,
      "DidCatchAlternativeSyntax.bs.js"
    )
  },
  output: {
    path: __dirname
  }
};
