var path = require("path");

module.exports = {
  mode: "development",
  entry: {
    "Counter.bundle": path.join(__dirname, "Counter.bs.js")
  },
  output: {
    path: __dirname
  }
};
