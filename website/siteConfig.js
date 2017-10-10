const users = [
  {
    caption: "Facebook",
    image: "img/logos/facebook.svg",
    infoLink: "https://www.facebook.com",
    pinned: true
  },
  {
    caption: "Messenger",
    image: "img/logos/messenger.svg",
    infoLink: "https://messenger.com",
    pinned: true
  },
  {
    caption: "WOW air",
    image: "img/logos/wowair.svg",
    infoLink: "https://wowair.com",
    pinned: true
  },
  {
    caption: "BeOpinion",
    image: "img/logos/beopinion.svg",
    infoLink: "https://beopinion.com",
    pinned: true
  },
  {
    caption: "Gain by Sentia",
    image: "img/logos/gain.svg",
    infoLink: "https://gain.ai",
    pinned: true
  },
];

const examples = [
  {
    name: "Hacker News",
    image: "img/examples/hn.png",
    link: "https://github.com/reasonml-community/reason-react-hacker-news",
  },
  {
    name: "TodoMVC",
    image: "img/examples/todomvc.png",
    link: "https://github.com/reasonml-community/reason-react-example/tree/master/src/todomvc",
  }
]

const siteConfig = {
  title: "ReasonReact" /* title for your website */,
  tagline: "A safer, simpler way to build React components",
  url: "https://reasonml.github.io/reason-react" /* your github url */,
  editUrl: "https://github.com/reasonml/reason-react/tree/master/docs/",
  recruitingLink: "https://crowdin.com/project/reason-react",
  sourceCodeButton: null,
  baseUrl: "/reason-react/" /* base url for your project */,
  projectName: "reason-react",
  headerLinks: [
    { doc: "installation", label: "Docs" },
    { doc: "simple", label: "Examples" },
    { doc: "community", label: "Community" },
    { blog: true, label: "Blog" },
    { languages: true },
    { search: true },
    { href: "https://github.com/reasonml/reason-react", label: "GitHub" },
  ],
  users,
  examples,
  /* path to images for header/footer */
  headerIcon: "img/reason-react-white.svg",
  footerIcon: "img/reason-react-white.svg",
  favicon: "img/reason-react-red.svg",
  /* colors for website */
  colors: {
    primaryColor: "#db4d3f",
    secondaryColor: "#db4d3f",
    prismColor:
      "rgba(243, 136, 136, 0.03)" /* primaryColor in rgba form, with 0.03 alpha */
  },
  algolia: {
    apiKey: "55156da6520de795d3a2c2d23786f08e",
    indexName: "react-reason"
  },
};

module.exports = siteConfig;
