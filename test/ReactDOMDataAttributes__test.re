open Jest;
open Jest.Expect;

[@mel.send]
external getAttribute: (Dom.element, string) => Js.nullable(string) =
  "getAttribute";

/* Exercise React's data attribute behavior through the existing cloning API.
   The JSX implementation can use the same assertions once it accepts data props. */
describe("ReactDOM data attributes", () => {
  test("renders data attributes alongside ordinary props", () => {
    let html =
      ReactDOMServer.renderToStaticMarkup(
        React.cloneElement(
          <div className="example">
            {React.cloneElement(<span />, { "data-foo-bar": "second" })}
          </div>,
          {
            "data-test-id": "first",
            "data-version2": "v2",
          },
        ),
      );
    expect(html)
    ->toBe(
        "<div class=\"example\" data-test-id=\"first\" data-version2=\"v2\"><span data-foo-bar=\"second\"></span></div>",
      );
  });

  test("omits absent optional attributes", () => {
    let render = dataFoo =>
      ReactDOMServer.renderToStaticMarkup(
        React.cloneElement(
          <div />,
          { "data-foo": Js.Undefined.fromOption(dataFoo) },
        ),
      );
    expect(render(None))->toBe("<div></div>");
    expect(render(Some("value")))->toBe("<div data-foo=\"value\"></div>");
  });

  test("updates and removes data attributes on the same DOM node", () => {
    let element = (value, state) =>
      React.cloneElement(
        <button />,
        {
          "data-value": value,
          "data-state": Js.Undefined.fromOption(state),
        },
      );
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
        React.cloneElement(
          <svg viewBox="0 0 10 10">
            {React.cloneElement(
               <path strokeWidth="2" />,
               { "data-version2": "v2" },
             )}
          </svg>,
          { "data-state": Js.Undefined.fromOption(dataState) },
        ),
      );
    expect(html)
    ->toBe(
        "<svg viewBox=\"0 0 10 10\" data-state=\"ready\"><path stroke-width=\"2\" data-version2=\"v2\"></path></svg>",
      );
  });

  test("preserves underscores in data attribute names", () => {
    let html =
      ReactDOMServer.renderToStaticMarkup(
        React.cloneElement(
          <div />,
          /* Dictionary keys bypass Melange's object-label name mangling. */
          Js.Dict.fromArray([|
            ("data-foo", "plain"),
            ("data-foo__bar", "double"),
            ("data-foo___", "trailing"),
          |]),
        ),
      );
    expect(html)
    ->toBe(
        "<div data-foo=\"plain\" data-foo__bar=\"double\" data-foo___=\"trailing\"></div>",
      );
  });

  test("preserves ordinary property renaming", () => {
    let container =
      ReactTestingLibrary.render(
        React.cloneElement(
          <button type_="button" ariaLabel="label" />,
          { "data-foo": "value" },
        ),
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
      React.cloneElement(
        <div className={next("class")}> {next("child")->React.string} </div>,
        { "data-foo": next("data") },
      );
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
        React.cloneElement(
          <div className=?{next("class")} />,
          { "data-foo": next("data")->Js.Undefined.fromOption },
        );
      expect(evaluations.contents)->toBe(2);
      let html = ReactDOMServer.renderToStaticMarkup(element);
      expect(evaluations.contents)->toBe(2);
      html;
    };
    expect(render(false))->toBe("<div></div>");
    expect(render(true))
    ->toBe("<div class=\"class\" data-foo=\"data\"></div>");
  });
});
