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
const Marked = CompLibrary.Marked; /* Used to read markdown */
const Container = CompLibrary.Container;
const GridBlock = CompLibrary.GridBlock;
const Prism = CompLibrary.Prism;

const translate = require("../../server/translate.js").translate;

const siteConfig = require(process.cwd() + "/siteConfig.js");

class Button extends React.Component {
  render() {
    return (
      <div className="pluginWrapper">
        <a className={`button ${this.props.className}`} href={this.props.href} target={this.props.target}>
          {this.props.children}
        </a>
      </div>
    );
  }
}

Button.defaultProps = {
  target: "_self"
};

const code =`let component = ReasonReact.statelessComponent "Greeting";

let make ::name _children => {
  ...component,
  render: fun _self =>
    <button>
      (ReasonReact.stringToElement "Hello!")
    </button>
};`;

class HomeSplash extends React.Component {
  // 
  render() {
    let promoSection =
      <div className="section promoSection">
        <div className="promoRow">
          <div className="pluginRowBlock">
            <Button
              className="getStarted"
              href={
                siteConfig.baseUrl +
                "docs/" +
                this.props.language +
                "/getting-started.html"
              }
            >
              <translate>Get Started</translate>
            </Button>
            <Button
              href="https://jaredforsyth.com/2017/07/05/a-reason-react-tutorial"
            >
              Tutorial
            </Button>
          </div>
        </div>
      </div>;
    return (
      <div className="homeContainer">

        <div id="redirectBanner">
          <div>
            Hello! This particular page hash has moved to <a id="redirectLink"/>.
            Please update the URLs to reflect it. Thanks!
          </div>
        </div>

        <div className="homeWrapperWrapper">

          <div className="wrapper homeWrapper">
            <div className="projectTitle">{siteConfig.title}</div>

            <div className="homeWrapperInner">
              <div className="homeTagLine">{siteConfig.tagline}</div>
              <div className="homeCodeSnippet">
                <Prism>{code}</Prism>
              </div>
            </div>

            {promoSection}
          </div>

        </div>
      </div>
    );
  }
}

class Index extends React.Component {
  render() {
    let language = this.props.language || "en";
    const showcase = siteConfig.users
      .filter(user => {
        return user.pinned;
      })
      .map(user => {
        return (
          <a href={user.infoLink}>
            <img src={user.image} title={user.caption} />
          </a>
        );
      });

    return (
      <div>
        <HomeSplash language={language} />
        <div className="mainContainer">
          <Container padding={["bottom"]}>
            <GridBlock
              align="center"
              contents={[
                {
                  title: "Safe and Sound",
                  content: "It's Just Reason. We leverage the existing type system to create a library that types just right.",
                },
                {
                  title: "Playground for Future React",
                  content: "Lightweight, first-class support for the ReactJS community idioms you've been using.",
                },
                {
                  title: "Drop In",
                  content: "Easily integrate ReasonReact into your existing app. Convert a file, quickly see benefits.",
                },
              ]}
              layout="threeColumn"
            />
          </Container>

          <Container padding={["bottom", "top"]} className="homeExamples">
            <GridBlock
              contents={[
                {
                  content: "Talk about learning how to use this",
                  image: siteConfig.baseUrl + "img/logo.png",
                  imageAlign: "right",
                  title: "Quick Start"
                },
                {
                  content: "Talk about learning how to use this",
                  image: siteConfig.baseUrl + "img/logo.png",
                  imageAlign: "right",
                  title: "Examples"
                },
              ]}
              layout="twoColumn"
            />
          </Container>

        </div>
        <script src={siteConfig.baseUrl + 'js/redirectIndex.js'}></script>
      </div>
    );
  }
}

module.exports = Index;
