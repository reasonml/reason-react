var path = require("path");

module.exports = {
  mode: "development",
  entry: {
    "Helloworld.bundle": path.join(__dirname, "Helloworld.bs.js")
  },
  output: {
    path: __dirname
  }
};
