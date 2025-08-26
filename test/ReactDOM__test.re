open Jest;
open Expect;

module Stream = {
  type writable = Js.t({.});

  [@mel.send] external setEncoding: (writable, string) => unit = "setEncoding";

  [@mel.send] external on: (writable, string, string => unit) => unit = "on";

  [@mel.module "stream"] [@mel.new]
  external make: unit => writable = "PassThrough";
};

describe("ReactDOM", () => {
  describe("data attributes JSX support", () => {
    test("jsx should render data-* attributes from JSX", () => {
      let element = <div data_testid="my-test" data_custom="value" className="container" />;
      let html = ReactDOMServer.renderToString(element);

      expect(html)->toContain("data-testid=\"my-test\"");
      expect(html)->toContain("data-custom=\"value\"");
      expect(html)->toContain("class=\"container\"");
    });

    test("should handle single data attribute", () => {
      let element = <div data_testid="foo" />;
      let html = ReactDOMServer.renderToString(element);

      expect(html)->toContain("data-testid=\"foo\"");
    });

    test("kebab-case conversion works correctly", () => {
      let element = <div data_test_id="kebab" data_user_name="john" />;
      let html = ReactDOMServer.renderToString(element);
      
      expect(html)->toContain("data-test-id=\"kebab\"");
      expect(html)->toContain("data-user-name=\"john\"");
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
  });
});
