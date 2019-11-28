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

// fake, static, responsive refmt, lol. See reason.css homeCodeSnippet logic
const codeExampleSmallScreen =`${pre}reason
[@react.component]
let make = (~name) =>
  <button>
    {React.string("Hello!")}
  </button>;
${pre}`;

const codeExampleLargeScreen =`${pre}reason
[@react.component]
let make = (~name) =>
  <button>
    {React.string("Hello!")}
  </button>;
${pre}`;

const quickStart = `${pre}bash
npm install -g bs-platform@6.2.1
bsb -init my-react-app -theme react-hooks
cd my-react-app
npm install && npm start
${pre}

Then open another tab and do:

${pre}bash
npm run server
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
                "/installation"
              }
            >
              <translate>Get Started</translate>
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
                <MarkdownBlock>{codeExampleSmallScreen}</MarkdownBlock>
                <MarkdownBlock>{codeExampleLargeScreen}</MarkdownBlock>
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
          <Container>
            <GridBlock
              align="center"
              contents={[
                {
                  title: <translate>Safe and Sound</translate>,
                  content: <translate>It's Just Reason. We leverage the existing type system to create a library that types just right.</translate>,
                },
                {
                  title: <translate>Playground for Future React</translate>,
                  content: <translate>Lightweight, first-class support for the ReactJS community idioms you've been using.</translate>,
                },
                {
                  title: <translate>Drop In</translate>,
                  content: <translate>Easily integrate ReasonReact into your existing app. Convert a file, quickly see benefits.</translate>,
                },
              ]}
              layout="threeColumn"
            />
          </Container>

          <Container background="light" className="quickStartAndExamples homeCodeSnippet">
            <div>
              <h2><translate>QuickStart</translate></h2>
              <MarkdownBlock>
                {quickStart}
              </MarkdownBlock>
            </div>
            <div>
              <h2><translate>Examples</translate></h2>
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
                href={`${siteConfig.baseUrl}${this.props.language}/built-with-reason-react`}
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
