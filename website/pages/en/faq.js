/**
 * This is a redirect page from our old docs.
 */

const React = require("react");

const translate = require("../../server/translate.js").translate;

const siteConfig = require(process.cwd() + "/siteConfig.js");

class FAQ extends React.Component {
  render() {
    return (
      <div>
        <div className="mainContainer">
          <div
            className="productShowcaseSection paddingBottom"
            style={{ textAlign: "center" }}
          >
            <h2>Our FAQ has moved!</h2>
            <div>Attempting redirect now...</div>
            <div>If you aren't redirected automatically please follow <a href={siteConfig.baseUrl + 'docs/en/common-errors.html'}>this link</a>.</div>
          </div>
          <script src={siteConfig.baseUrl + 'js/redirect.js'}></script>
        </div>
      </div>
    );
  }
}

module.exports = FAQ;
