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

  test("preserves underscores in data attribute names", () => {
    let html =
      ReactDOMServer.renderToStaticMarkup(
        <div dataFoo="plain" dataFoo__bar="double" dataFoo___="trailing" />,
      );
    expect(html)
    ->toBe(
        "<div data-foo=\"plain\" data-foo__bar=\"double\" data-foo___=\"trailing\"></div>",
      );
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
