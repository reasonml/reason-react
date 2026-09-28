open Jest;
open Jest.Expect;

module Stream = {
  type writable = Js.t({.});

  [@mel.send] external setEncoding: (writable, string) => unit = "setEncoding";

  [@mel.send] external on: (writable, string, string => unit) => unit = "on";

  [@mel.module "stream"] [@mel.new]
  external make: unit => writable = "PassThrough";
};

describe("ReactDOM", () => {
  describe("data attributes", () => {
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
      expect(render(Some("value")))
      ->toBe("<div data-foo=\"value\"></div>");
    });

    test("preserves ordinary property renaming", () => {
      let html =
        ReactDOMServer.renderToStaticMarkup(
          <button type_="button" ariaLabel="label" dataFoo="value" />,
        );
      expect(html)
      ->toBe(
          "<button type=\"button\" aria-label=\"label\" data-foo=\"value\"></button>",
        );
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
  });

  describe("ReactDOM.Server", () => {
    test("renderToString", () => {
      let string =
        ReactDOMServer.renderToString(
          <div> "Hello world!"->React.string </div>,
        );
      expect(string)->toBe("<div>Hello world!</div>");
    });
    test("renderToStaticMarkup", () => {
      let string =
        ReactDOMServer.renderToStaticMarkup(
          <div> "Hello world!"->React.string </div>,
        );
      expect(string)->toBe("<div>Hello world!</div>");
    });

    testAsync("renderToPipeableStream", finish => {
      let buffer = ref("");
      let hasErrored = ref(false);
      let stream = Stream.make();
      Stream.setEncoding(stream, "utf8");
      Stream.on(
        stream,
        "data",
        data => {
          buffer := buffer.contents ++ data;
          expect(buffer.contents)->toBe("<div>Hello world!</div>");
          expect(hasErrored.contents)->toBe(false);

          finish();
        },
      );
      Stream.on(
        stream,
        "error",
        error => {
          buffer := buffer.contents ++ error;
          hasErrored := true;
        },
      );
      let {pipe, abort: _}: ReactDOMServerNode.pipeableStream(_) =
        ReactDOMServerNode.renderToPipeableStream(
          <div> "Hello world!"->React.string </div>,
        );
      pipe(stream);
    });
  })
});
