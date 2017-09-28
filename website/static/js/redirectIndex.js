/*
 * This code is not run through any build step! Don't add any fancy stuff
 */

(function() {
  // redirects[page][hash] => new page;
  var redirects = {
    'reason-react': 'reason-react.html',
    'intro-example': 'intro-example.html',
    'jsx': 'jsx.html',
    'jsx-uncapitalized': 1,
    'jsx-capitalized': 1,
    'component-creation': 'component-creation.html',
    'react-element': 'react-element.html',
    'interop-with-existing-javascript-components': 'interop.html',
    'events': 'events.html',
    'styles': 'styles.html',
    'cloneelement': 'cloneElement.html',
    'working-with-children': 'children.html',
    'working-with-dom': 'dom.html',
    'convert-over-reactjs-idioms': 'convert.html',
    'miscellaneous.html': 'getting-started.html#reason-scripts',
    'common-type-errors': 'common-errors.html',
  };
  // they all start with reason-react
  var hash = window.location.hash
  if (hash.indexOf('reason-react') !== 1) {
    return;
  }
  if (hash === '#reason-react') {
    hash = 'reason-react';
  } else {
    hash = hash.split('reason-react-')[1];
  }
  var path = window.location.pathname.split('/');
  var page = path[path.length - 1];
  var base = '/reason-react/docs/en/';
  Object.keys(redirects).forEach(function(redirect) {
    if (redirect.indexOf(hash) === 0) {
      var newHash = redirect.split(hash + '-')[1] || '';
      newHash = newHash ? '#' + newHash : newHash;
      window.location.replace(base + redirects[redirect] + newHash);
    }
  });
})();
