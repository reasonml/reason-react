/**
 * This is a redirect page from our old docs.
 */

const React = require("react");

const siteConfig = require(process.cwd() + "/siteConfig.js");

class Examples extends React.Component {
  render() {
    return (
      <div>
        <div id="redirectMessage">
          Hello! This page has moved to <a id="redirectLink"/>.
          Please update the URLs to reflect it. Thanks!
        </div>
        <script src={siteConfig.baseUrl + 'js/redirect.js'}></script>
      </div>
    );
  }
}

module.exports = Examples;
