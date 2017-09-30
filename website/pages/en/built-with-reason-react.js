/**
 * Copyright (c) 2017-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

const React = require("react");

const CompLibrary = require("../../core/CompLibrary.js");
const Container = CompLibrary.Container;

const translate = require("../../server/translate.js").translate;

const siteConfig = require(process.cwd() + "/siteConfig.js");

class Users extends React.Component {
  render() {
    const showcase = siteConfig.users.map(user => {
      return (
        <a href={user.infoLink}>
          <img
            src={`${siteConfig.baseUrl}${user.image}`}
            title={user.caption}
          />
        </a>
      );
    });

    return (
      <div className="mainContainer">
        <Container>
          <div className="showcaseSection">
            <div className="prose">
              <h1><translate>Built With ReasonReact</translate></h1>
            </div>
            <div className="logos">
              {showcase}
            </div>
            <a
              href="https://github.com/reasonml/reason-react/edit/master/website/siteConfig.js"
              className="button addCompanyButton"
            >
              Add yours
            </a>
          </div>
        </Container>
      </div>
    );
  }
}

module.exports = Users;
