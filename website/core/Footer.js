/**
 * Copyright (c) 2017-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

const React = require("react");

const highlighterCode = `
function fn() {
  Array.prototype.forEach.call(
    document.querySelectorAll("pre"),
    hljs.highlightBlock
  );
};
if (document.attachEvent ? document.readyState === "complete" : document.readyState !== "loading"){
  fn();
} else {
  document.addEventListener('DOMContentLoaded', fn);
}
`;

class Footer extends React.Component {
  render() {
    return <script src={this.props.config.baseUrl + 'js/redirectBlog.js'}></script>;
    const currentYear = new Date().getFullYear();
    return (
      <footer className="nav-footer" id="footer">
        <section className="sitemap">
          <a href={this.props.config.baseUrl} className="nav-home">
            <img
              src={this.props.config.baseUrl + this.props.config.footerIcon}
              alt={this.props.config.title}
              width="66"
              height="58"
            />
          </a>
          <div>
            <h5>Docs</h5>
            <a
              href={
                this.props.config.baseUrl +
                "docs/" +
                this.props.language +
                "/getting-started.html"
              }
            >
              Getting Started
            </a>
            <a
              href={
                this.props.config.baseUrl +
                "docs/" +
                this.props.language +
                "/simple.html"
              }
            >
              Examples
            </a>
            <a
              href={
                this.props.config.baseUrl +
                "docs/" +
                this.props.language +
                "/common-errors.html"
              }
            >
              FAQ
            </a>
          </div>
          <div>
            <h5>Community</h5>
            <a href="https://discord.gg/reasonml" target="_blank">
              Discord
            </a>
            <a href="https://twitter.com/reasonml" target="_blank">
              Twitter
            </a>
            <a
              href="https://stackoverflow.com/questions/tagged/reason-react"
              target="_blank"
            >
              Stack Overflow
            </a>
          </div>
          <div>
            <h5>More</h5>
            <a href={this.props.config.baseUrl + "blog"}>Blog</a>
            <a href="https://github.com/reasonml/reason-react">GitHub</a>
          </div>
        </section>
      </footer>
    );
  }
}

module.exports = Footer;
