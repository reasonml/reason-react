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
      let element = <div data_testid="my-test" />;
      let html = ReactDOMServer.renderToString(element);

      expect(html)->toContain("data-testid=\"my-test\"");
    });

    test("jsx should render data-* attributes with different values", () => {
      let element = <div data_testid="another-test" />;
      let html = ReactDOMServer.renderToString(element);

      expect(html)->toContain("data-testid=\"another-test\"");
    });

    test("jsx should render multiple data-* attributes on same element", () => {
      let element = <div data_testid="multi-test" data_custom="value" />;
      let html = ReactDOMServer.renderToString(element);

      expect(html)->toContain("data-testid=\"multi-test\"");
      expect(html)->toContain("data-custom=\"value\"");
    });

    test("jsx should handle data attributes with underscores", () => {
      let element = <div data_test_id="underscore-test" />;
      let html = ReactDOMServer.renderToString(element);

      expect(html)->toContain("data-test-id=\"underscore-test\"");
    });

    test("jsx should render data attributes on different element types", () => {
      let spanElement = <span data_role="button" />;
      let buttonElement = <button data_analytics="click" />;
      let spanHtml = ReactDOMServer.renderToString(spanElement);
      let buttonHtml = ReactDOMServer.renderToString(buttonElement);

      expect(spanHtml)->toContain("data-role=\"button\"");
      expect(buttonHtml)->toContain("data-analytics=\"click\"");
    });

    test("jsx should handle empty data attribute values", () => {
      let element = <div data_empty="" />;
      let html = ReactDOMServer.renderToString(element);

      expect(html)->toContain("data-empty=\"\"");
    });

    test("jsx should handle complex data attribute names", () => {
      let element = <div data_complex_name_with_underscores="value" />;
      let html = ReactDOMServer.renderToString(element);

      expect(html)->toContain("data-complex-name-with-underscores=\"value\"");
    });

    test("jsx should work with multiple separate elements having data attributes", () => {
      let parentElement = <div data_parent="outer" />;
      let childElement = <span data_child="inner" />;
      let parentHtml = ReactDOMServer.renderToString(parentElement);
      let childHtml = ReactDOMServer.renderToString(childElement);

      expect(parentHtml)->toContain("data-parent=\"outer\"");
      expect(childHtml)->toContain("data-child=\"inner\"");
    });

    test("jsx should handle numeric data attribute values", () => {
      let element = <div data_count="42" data_price="19.99" />;
      let html = ReactDOMServer.renderToString(element);

      expect(html)->toContain("data-count=\"42\"");
      expect(html)->toContain("data-price=\"19.99\"");
    });

    test("jsx should handle boolean-like data attribute values", () => {
      let element = <div data_active="true" data_disabled="false" />;
      let html = ReactDOMServer.renderToString(element);

      expect(html)->toContain("data-active=\"true\"");
      expect(html)->toContain("data-disabled=\"false\"");
    });

    test("jsx should handle data attributes with special characters", () => {
      let element = <div data_info="Hello, World! @#$%^&*()" />;
      let html = ReactDOMServer.renderToString(element);

      expect(html)->toContain("data-info=\"Hello, World! @#$%^&amp;*()\"");
    });

    test("jsx should handle data attributes on input elements", () => {
      let element = <input data_field="username" data_validation="required" />;
      let html = ReactDOMServer.renderToString(element);

      expect(html)->toContain("data-field=\"username\"");
      expect(html)->toContain("data-validation=\"required\"");
    });

    test("jsx should handle many data attributes on single element", () => {
      let element = <div data_a="1" data_b="2" data_c="3" data_d="4" data_e="5" />;
      let html = ReactDOMServer.renderToString(element);

      expect(html)->toContain("data-a=\"1\"");
      expect(html)->toContain("data-b=\"2\"");
      expect(html)->toContain("data-c=\"3\"");
      expect(html)->toContain("data-d=\"4\"");
      expect(html)->toContain("data-e=\"5\"");
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
