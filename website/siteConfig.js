/**
 * Copyright (c) 2017-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

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
    { href: "https://github.com/reasonml/reason-react", label: "GitHub" },
  ],
  users,
  examples,
  /* path to images for header/footer */
  headerIcon: "img/reason-react-white.svg",
  footerIcon: "img/reason-react-white.svg",
  favicon: "img/favicon/favicon.png",
  /* colors for website */
  colors: {
    primaryColor: "#db4d3f",
    secondaryColor: "#db4d3f",
    prismColor:
      "rgba(243, 136, 136, 0.03)" /* primaryColor in rgba form, with 0.03 alpha */
  }
};

module.exports = siteConfig;
