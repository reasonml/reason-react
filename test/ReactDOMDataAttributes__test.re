open Jest;
open Jest.Expect;

[@mel.send]
external getAttribute: (Dom.element, string) => Js.nullable(string) =
  "getAttribute";

describe("ReactDOM data attributes", () => {
  test("renders arbitrary camelCase names alongside ordinary props", () => {
    let html =
      ReactDOMServer.renderToStaticMarkup(
        <div className="example" dataTestId="first" dataVersion2="v2">
          <span dataFooBar="second" />
        </div>,
      );
    expect(html)
    ->toBe(
        "<div class=\"example\" data-test-id=\"first\" data-version2=\"v2\"><span data-foo-bar=\"second\"></span></div>",
      );
  });

  test("omits absent optional attributes", () => {
    let render = dataFoo =>
      ReactDOMServer.renderToStaticMarkup(<div ?dataFoo />);
    expect(render(None))->toBe("<div></div>");
    expect(render(Some("value")))->toBe("<div data-foo=\"value\"></div>");
  });

  test("updates and removes data attributes on the same DOM node", () => {
    let element = (value, state) =>
      <button dataValue=value dataState=?state />;
    let container = ReactTestingLibrary.render(element("first", None));
    let button =
      ReactTestingLibrary.getByRole(~matcher=`Str("button"), container);
    let attribute = name => getAttribute(button, name)->Js.Nullable.toOption;

    expect(attribute("data-value"))->toEqual(Some("first"));
    expect(attribute("data-state"))->toEqual(None);

    ReactTestingLibrary.rerender(
      element("second", Some("ready")),
      container,
    );
    expect(attribute("data-value"))->toEqual(Some("second"));
    expect(attribute("data-state"))->toEqual(Some("ready"));

    ReactTestingLibrary.rerender(element("third", Some("")), container);
    expect(attribute("data-state"))->toEqual(Some(""));

    ReactTestingLibrary.rerender(element("last", None), container);
    expect(attribute("data-value"))->toEqual(Some("last"));
    expect(attribute("data-state"))->toEqual(None);
    expect(
      ReactTestingLibrary.getByRole(~matcher=`Str("button"), container),
    )
    ->toBe(button);
  });

  test("supports data attributes on SVG elements", () => {
    let dataState = Some("ready");
    let html =
      ReactDOMServer.renderToStaticMarkup(
        <svg viewBox="0 0 10 10" ?dataState>
          <path strokeWidth="2" dataVersion2="v2" />
        </svg>,
      );
    expect(html)
    ->toBe(
        "<svg viewBox=\"0 0 10 10\" data-state=\"ready\"><path stroke-width=\"2\" data-version2=\"v2\"></path></svg>",
      );
  });

  test("matches server-reason-react data attribute names", () => {
    let html =
      ReactDOMServer.renderToStaticMarkup(
        <div
          dataFoo="plain"
          dataFoo__bar="double"
          dataFoo___="trailing"
          dataFoo_bar="single"
          dataVersion20="digits"
          dataURL="acronym"
          dataURLPath="acronym then word"
          data2="leading digit"
          datafoo="lowercase"
        />,
      );
    expect(html)
    ->toBe(
        "<div data-foo=\"plain\" data-foo--bar=\"double\" data-foo---=\"trailing\" data-foo-bar=\"single\" data-version20=\"digits\" data-url=\"acronym\" data-url-path=\"acronym then word\" data2=\"leading digit\" datafoo=\"lowercase\"></div>",
      );
  });

  test("converts underscores and acronym word boundaries", () => {
    let html =
      ReactDOMServer.renderToStaticMarkup(
        <div
          data_foo="leading underscore"
          dataFoo_Bar="underscore then uppercase"
          data_API_KEY="uppercase words"
          dataURL2Path="digit then uppercase"
          dataXMLHttpRequest="acronym then lowercase"
        />,
      );
    expect(html)
    ->toBe(
        "<div data-foo=\"leading underscore\" data-foo-bar=\"underscore then uppercase\" data-api-key=\"uppercase words\" data-url2-path=\"digit then uppercase\" data-xml-http-request=\"acronym then lowercase\"></div>",
      );
  });

  test("uses server-compatible names for optional data attributes", () => {
    let render = (dataVersion2, data_foo) =>
      ReactDOMServer.renderToStaticMarkup(<div ?dataVersion2 ?data_foo />);
    expect(render(None, None))->toBe("<div></div>");
    expect(render(Some("v2"), Some("value")))
    ->toBe("<div data-version2=\"v2\" data-foo=\"value\"></div>");
  });

  test("preserves ordinary property renaming", () => {
    let container =
      ReactTestingLibrary.render(
        <button type_="button" ariaLabel="label" dataFoo="value" />,
      );
    let button =
      ReactTestingLibrary.getByRole(~matcher=`Str("button"), container);
    let attribute = name => getAttribute(button, name)->Js.Nullable.toOption;
    expect(attribute("type"))->toEqual(Some("button"));
    expect(attribute("aria-label"))->toEqual(Some("label"));
    expect(attribute("data-foo"))->toEqual(Some("value"));
  });

  test("accepts repeated data prop labels", () => {
    let element = <div dataFoo="first" dataFoo="second" />;
    expect(ReactDOMServer.renderToStaticMarkup(element))
    ->toBe("<div data-foo=\"first\"></div>");
  });

  test("matches parsed server HTML for colliding names", () => {
    let serverHtml =
      "<button data-foo=\"first\" data-foo=\"second\" data-foo-bar=\"word\" data-foo-bar=\"other word\" data-url=\"url\" data-url=\"other url\">server</button>";
    let server =
      ReactTestingLibrary.render(
        <div dangerouslySetInnerHTML={{"__html": serverHtml}} />,
      );
    let client =
      ReactTestingLibrary.render(
        <button
          dataFoo="first"
          data_foo="second"
          dataFoo_bar="word"
          dataFoo_Bar="other word"
          dataURL="url"
          dataUrl="other url">
          {React.string("client")}
        </button>,
      );
    let button = (text, container) =>
      ReactTestingLibrary.getByText(~matcher=`Str(text), container);
    List.iter(
      name =>
        expect(getAttribute(button("client", client), name))
        ->toEqual(getAttribute(button("server", server), name)),
      ["data-foo", "data-foo-bar", "data-url"],
    );
  });

  test("keeps the first present optional alias", () => {
    let render = (first, second) =>
      ReactDOMServer.renderToStaticMarkup(
        <div dataFoo=?first data_foo=?second />,
      );
    expect(render(None, None))->toBe("<div></div>");
    expect(render(Some("first"), None))
    ->toBe("<div data-foo=\"first\"></div>");
    expect(render(None, Some("second")))
    ->toBe("<div data-foo=\"second\"></div>");
    expect(render(Some("first"), Some("second")))
    ->toBe("<div data-foo=\"first\"></div>");
    expect(render(Some(""), Some("second")))
    ->toBe("<div data-foo=\"\"></div>");
  });

  test("keeps a required value before an optional alias", () => {
    let render = second =>
      ReactDOMServer.renderToStaticMarkup(
        <div dataFoo="first" data_foo=?second />,
      );
    expect(render(None))->toBe("<div data-foo=\"first\"></div>");
    expect(render(Some("second")))->toBe("<div data-foo=\"first\"></div>");
  });

  test("falls through absent aliases to a required value", () => {
    let render = (first, second) =>
      ReactDOMServer.renderToStaticMarkup(
        <div dataURL=?first dataUrl=?second data_URL="fallback" />,
      );
    expect(render(None, None))->toBe("<div data-url=\"fallback\"></div>");
    expect(render(Some("first"), Some("second")))
    ->toBe("<div data-url=\"first\"></div>");
    expect(render(None, Some("second")))
    ->toBe("<div data-url=\"second\"></div>");
  });

  test("evaluates colliding prop expressions once even when discarded", () => {
    let evaluations = ref(0);
    let next = value => {
      incr(evaluations);
      value;
    };
    let element =
      <div
        className={next("class")}
        dataFoo={next("first")}
        data_foo=?Some(next("second"))>
        {next("child")->React.string}
      </div>;
    expect(evaluations.contents)->toBe(4);
    expect(ReactDOMServer.renderToStaticMarkup(element))
    ->toBe("<div class=\"class\" data-foo=\"first\">child</div>");
    expect(evaluations.contents)->toBe(4);
  });

  test("evaluates each prop expression once", () => {
    let evaluations = ref(0);
    let next = value => {
      incr(evaluations);
      value;
    };
    let element =
      <div className={next("class")} dataFoo={next("data")}>
        {next("child")->React.string}
      </div>;
    expect(evaluations.contents)->toBe(3);
    expect(ReactDOMServer.renderToStaticMarkup(element))
    ->toBe("<div class=\"class\" data-foo=\"data\">child</div>");
    expect(evaluations.contents)->toBe(3);
  });

  test("evaluates optional prop expressions once", () => {
    let render = present => {
      let evaluations = ref(0);
      let next = value => {
        incr(evaluations);
        present ? Some(value) : None;
      };
      let element =
        <div className=?{next("class")} dataFoo=?{next("data")} />;
      expect(evaluations.contents)->toBe(2);
      let html = ReactDOMServer.renderToStaticMarkup(element);
      expect(evaluations.contents)->toBe(2);
      html;
    };
    expect(render(false))->toBe("<div></div>");
    expect(render(true))
    ->toBe("<div class=\"class\" data-foo=\"data\"></div>");
  });

  test("evaluates the final unit argument once", () => {
    let evaluations = ref(0);
    let nextUnit = () => incr(evaluations);
    let element = [@JSX] div(~dataFoo="value", nextUnit());
    expect(evaluations.contents)->toBe(1);
    expect(ReactDOMServer.renderToStaticMarkup(element))
    ->toBe("<div data-foo=\"value\"></div>");
    expect(evaluations.contents)->toBe(1);
  });
});
