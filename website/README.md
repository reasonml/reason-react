# ReasonReact Website

This code is used to generate [https://reasonml.github.io/reason-react](https://reasonml.github.io/reason-react). It pulls in files from `../docs` and the current directory to generate the final static html files that's served on the site.

`website/` contains the actual js, css, images and other files (and blog, which contains some markdown files too, these are separated from `docs/`, not too important).

`npm start` to start the server & watcher. The other scripts in package.json should also be self-descriptive.

Don't use `npm build` for now.

In the end, we spit out normal HTML, with all the JS dependencies (barring a few critical ones) removed, including ReactJS itself. It's a full, static website, super lightweight, portable, unfancy but good looking.

Two special files:

- `sidebars.json`: lists the sections.

- `siteConfig.json`: some header and i18n configs.

During your development, most changes will be picked up at each browser refresh. If you touch these two files or `blog/`, however, you'll have to restart the server to see the changes.

## Translations

The entire site can be translated via the [Crowdin project](https://crowdin.com/project/reason-react). This repo only has the canonical english documentation. Don't manually edit things in `i18n/`.

## Debugging

`console.log`s appear in your terminal! Since the site itself is React-free.

## Building and Deploying

*TODO*
Ping @rickyvetter if you'd like to try it eagerly.
