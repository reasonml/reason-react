var path = require("path");

module.exports = {
  mode: "development",
  entry: {
    "DerivedState.bundle": path.join(__dirname, "DerivedState.bs.js")
  },
  output: {
    path: __dirname
  }
};
