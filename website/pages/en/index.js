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
npm install -g bs-platform
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
            <Button
              className="getStarted"
              href={
                siteConfig.baseUrl + "docs/" + this.props.language + "/simple"
              }
            >
              <translate>Examples</translate>
            </Button>
          </div>
        </div>
      </div>;

    return (
      <div className="homeContainer">
        <div className="homeContainer homeContainerWrapper homeBanner">
          Black Lives Matter.{' '}
          <a target="_blank" href="https://support.eji.org/give/153413/#!/donation/checkout">
            Support the Equal Justice Initiative
           </a>.
         </div>
        <div id="redirectBanner">
          <div>
            Hello! This particular page hash has moved to <a id="redirectLink" />.
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
                  title: <translate>It's Just React</translate>,
                  content: <translate>Just a bunch of zero-runtime type definitions and lightweight utilities, for the same React you've come to know.</translate>,
                },
                {
                  title: <translate>Safe and Sound</translate>,
                  content: <translate>Simple, solid and inferred using Reason types. Write the same React code, get your type system guarantees automatically.</translate>,
                },
                {
                  title: <translate>Drop In</translate>,
                  content: <translate>Powered by ReactJS under the hood. Freely integrate your existing React libraries and knowledge.</translate>,
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
