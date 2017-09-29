/*
 * This code is not run through any build step! Don't add any fancy stuff
 */

(function() {
  var faq = {
    '#frequently-asked-questions-common-type-errors': 'common-errors.html',
    '#frequently-asked-questions-how-do-i-do-props-spreading-div-thisprops': 'props-spread.html',
    default: 'common-errors.html'
  };
  var examples = {
    '#examples-simple': 'simple.html',
    '#examples-counter': 'counter.html',
    '#examples-reasonreact-using-reactjs': 'retained-props.html',
    '#examples-reasonreact-using-reactjs': 'reason-using-js.html',
    '#examples-reactjs-using-reasonreact': 'js-using-reason.html',
    default: 'simple.html'
  };
  var gettingStarted = {
    '#getting-started': 'getting-started.html',
    '#getting-started-bsb': 'getting-started.html#bsb',
    '#getting-started-reason-scripts': 'getting-started.html#reason-scripts',
    default: 'getting-started.html'
  };
  // redirects[page][hash] => new page;
  // yarn start only supports faq.html format, but gh pages upens up the other two.
  var redirects = {
    'faq.html': faq,
    'faq': faq,
    'faq/': faq,
    'examples': examples,
    'examples': examples,
    'examples/': examples,
    'gettingStarted.html': gettingStarted,
    'gettingStarted': gettingStarted,
    'gettingStarted/': gettingStarted,
  };
  var hash = window.location.hash;
  var path = window.location.pathname.split('/');
  var page = path[path.length - 1];
  if (redirects[page]) {
    var link = document.getElementById('redirectLink');
    var location = base +
      (redirects[page][hash] || redirects[page].default);
    link.textContent = 'https://reasonml.github.io/reason-react/docs/en/' + location;
    link.href = location;
  }
})();
