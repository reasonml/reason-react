/**
 * Copyright (c) 2017-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

const React = require("react");

class Footer extends React.Component {
  render() {
    return (
      <span>
        <script src={this.props.config.baseUrl + 'js/redirectBlog.js'}></script>
        <script src={this.props.config.baseUrl + 'js/pjax-api.js'}></script>
        <script dangerouslySetInnerHTML={{__html: `window.foo = new Pjax({
          areas: [
            // try to use the first query.
            '.mainContainer, .docsNavContainer .toc .navWrapper',
            // fallback
            'body'
          ],
          link: '.docsNavContainer:not(.docsSliderActive) a',
          update: {
            script: false,
          }
        });
        var languagesMenuItemCopy = document.getElementById("languages-menu");
        languagesMenuItemCopy.addEventListener("click", function(e){
          e.preventDefault();
          e.stopPropagation();
          e.stopImmediatePropagation();
        });`}}></script>
      </span>
    );
  }
}

module.exports = Footer;
