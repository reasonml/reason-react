const React = require("react");

const CompLibrary = require("../../core/CompLibrary.js");
const MarkdownBlock = CompLibrary.MarkdownBlock; /* Used to read markdown */
const Container = CompLibrary.Container;
const GridBlock = CompLibrary.GridBlock;

const translate = require("../../server/translate.js").translate;

const siteConfig = require(process.cwd() + "/siteConfig.js");

class Button extends React.Component {
  render() {
    return (
      <div className="pluginWrapper">
        <a className={`button ${this.props.className || ""}`} href={this.props.href} target={this.props.target}>
          {this.props.children}
        </a>
      </div>
    );
  }
}

Button.defaultProps = {
  target: "_self"
};
const pre = "```";
const code = "`";

const codeExample =`${pre}reason
let component = ReasonReact.statelessComponent("Greeting");

let make = (~name, _children) => {
  ...component,
  render: (_self) =>
    <button>
      {ReasonReact.stringToElement("Hello!")}
    </button>
};
${pre}`;


const quickStart = `${pre}bash
npm install -g bs-platform
bsb -init my-react-app -theme react
cd my-react-app
npm install && npm start
${pre}

Then open another tab and do:

${pre}bash
npm run webpack
${pre}

Your apps are the html files inside ${code}src/${code}`;

class HomeSplash extends React.Component {
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
                "/installation.html"
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

          <img src={siteConfig.baseUrl + siteConfig.headerIcon} className="spinner" />

          <div className="wrapper homeWrapper">
            <div className="projectTitle">{siteConfig.title}</div>

            <div className="homeWrapperInner">
              <div className="homeTagLine">{siteConfig.tagline}</div>
              <div className="homeCodeSnippet">
                <MarkdownBlock>{codeExample}</MarkdownBlock>
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
          <a href={user.infoLink} key={user.caption}>
            <img src={`${siteConfig.baseUrl}${user.image}`} title={user.caption} />
          </a>
        );
      });

    return (
      <div>
        <HomeSplash language={language} />
        <div className="mainContainer">
          <Container className="homeThreePoints" padding={["bottom"]}>
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

          <Container background="light" className="quickStartAndExamples homeCodeSnippet">
            <div>
              <h2>Quick Start</h2>
              <MarkdownBlock>
                {quickStart}
              </MarkdownBlock>
            </div>
            <div>
              <h2>Examples</h2>
              <GridBlock
                className="examples"
                align="center"
                contents={siteConfig.examples.map(example => ({
                  title: example.name,
                  image: `${siteConfig.baseUrl}${example.image}`,
                  imageLink: example.link,
                  imageAlign: "top",
                  content: "",
                }))}
                layout="twoColumn"
              />
          </div>
          </Container>

          <div className="productShowcaseSection paddingBottom">
            <h2>
              <translate>Projects Using ReasonReact</translate>
            </h2>
            <div className="logos">
              {showcase}
            </div>
            <div className="more-users">
              <a
                className="button"
                href={`${siteConfig.baseUrl}${this.props.language}/built-with-reason-react.html`}
              >
                <translate>See Full List</translate>
              </a>
            </div>
          </div>
        </div>
        <script src={siteConfig.baseUrl + 'js/redirectIndex.js'}></script>
      </div>
    );
  }
}

module.exports = Index;
