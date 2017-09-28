/*
 * This code is not run through any build step! Don't add any fancy stuff
 */

(function() {
  // redirects[page][hash] => new page;
  var redirects = {
    'faq.html': {
      '#frequently-asked-questions-common-type-errors': 'common-errors.html',
      '#frequently-asked-questions-how-do-i-do-props-spreading-div-thisprops': 'props-spread.html',
      default: 'common-errors.html'
    },
    'examples.html': {
      '#examples-simple': 'simple.html',
      '#examples-counter': 'counter.html',
      '#examples-reasonreact-using-reactjs': 'retained-props.html',
      '#examples-reasonreact-using-reactjs': 'reason-using-js.html',
      '#examples-reactjs-using-reasonreact': 'js-using-reason.html',
      default: 'simple.html'
    },
    'blog.html': {
      '#reducers-are-here': '2017/09/01/reducers.html',
      '#reducers-are-here-design-decisions': '2017/09/01/reducers.html#design-decisions',
      '#021-released': '2017/07/05/021.html',
      '#015-released': '2017/06/21/015.html',
      '#major-new-release': '2017/06/09/major-release.html',
      default: ''
    },
    'gettingStarted.html': {
      '#getting-started': 'getting-started.html',
      '#getting-started-bsb': 'getting-started.html#bsb',
      '#getting-started-reason-scripts': 'getting-started.html#reason-scripts',
      default: 'getting-started.html'
    }
  };
  var hash = window.location.hash;
  var path = window.location.pathname.split('/');
  var page = path[path.length - 1];
  var base = page === 'blog.html'
    ? '/reason-react/blog/'
    : '/reason-react/docs/en/';
  if (redirects[page]) {
    var link = document.getElementById('redirectLink');
    var location = base +
      (redirects[page][hash] || redirects[page].default);
    link.textContent = 'https://reasonml.github.io' + location;
    link.href = location;
  }
})();
