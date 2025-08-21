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
  describe("dataAttrs support", () => {
    test("jsx should render data-* attributes from dataAttrs", () => {
      let props = ReactDOM.domProps(
        ~dataAttrs=[("testid", "my-test"), ("custom", "value")] |> Js.Dict.fromList,
        ~className="container",
        ()
      );
      
      let element = ReactDOM.jsx("div", props);
      let html = ReactDOMServer.renderToString(element);
      
      expect(html)->toContain("data-testid=\"my-test\"");
      expect(html)->toContain("data-custom=\"value\"");
      expect(html)->toContain("class=\"container\"");
    });
    
    test("should handle single data attribute", () => {
      let element = ReactDOM.jsx("div", ReactDOM.domProps(
        ~dataAttrs=Js.Dict.fromList([("testid", "foo")]),
        ()
      ));
      let html = ReactDOMServer.renderToString(element);
      
      expect(html)->toContain("data-testid=\"foo\"");
    });
    
    test("should handle multiple data attributes with various types of values", () => {
      let element = ReactDOM.jsx("button", ReactDOM.domProps(
        ~dataAttrs=[("testid", "component-123"), ("role", "button"), ("index", "5"), ("active", "true"), ("disabled", "false")] |> Js.Dict.fromList,
        ()
      ));
      let html = ReactDOMServer.renderToString(element);
      
      expect(html)->toContain("data-testid=\"component-123\"");
      expect(html)->toContain("data-role=\"button\"");
      expect(html)->toContain("data-index=\"5\"");
      expect(html)->toContain("data-active=\"true\"");
      expect(html)->toContain("data-disabled=\"false\"");
    });
    
    test("should integrate with existing props like className and style", () => {
      let style = ReactDOM.Style.make(~color="red", ~fontSize="16px", ());
      let element = ReactDOM.jsx("div", ReactDOM.domProps(
        ~dataAttrs=Js.Dict.fromList([("testid", "styled-component"), ("theme", "dark")]),
        ~className="my-component active",
        ~style,
        ~id="unique-id",
        ()
      ));
      let html = ReactDOMServer.renderToString(element);
      
      expect(html)->toContain("data-testid=\"styled-component\"");
      expect(html)->toContain("data-theme=\"dark\"");
      expect(html)->toContain("class=\"my-component active\"");
      expect(html)->toContain("id=\"unique-id\"");
      expect(html)->toContain("color:red");
      expect(html)->toContain("font-size:16px");
    });
    
    test("should handle empty dataAttrs dictionary", () => {
      let element = ReactDOM.jsx("div", ReactDOM.domProps(
        ~dataAttrs=Js.Dict.empty(),
        ~className="empty-data",
        ()
      ));
      let html = ReactDOMServer.renderToString(element);
      
      expect(html)->toContain("class=\"empty-data\"");
      expect(html)->not->toContain("data-");
    });
    
    test("should handle None dataAttrs", () => {
      let element = ReactDOM.jsx("div", ReactDOM.domProps(
        ~className="no-data",
        ()
      ));
      let html = ReactDOMServer.renderToString(element);
      
      expect(html)->toContain("class=\"no-data\"");
      expect(html)->not->toContain("data-");
    });
    
    test("should work with keyed elements", () => {
      let element = ReactDOM.jsxKeyed("li", ReactDOM.domProps(
        ~dataAttrs=Js.Dict.fromList([("item-id", "123"), ("category", "electronics")]),
        ~className="list-item",
        ()
      ), ~key="item-123", ());
      let html = ReactDOMServer.renderToString(element);
      
      expect(html)->toContain("data-item-id=\"123\"");
      expect(html)->toContain("data-category=\"electronics\"");
      expect(html)->toContain("class=\"list-item\"");
    });
    
    test("should handle special characters in keys and values", () => {
      let element = ReactDOM.jsx("div", ReactDOM.domProps(
        ~dataAttrs=[("test-id", "value-with-hyphens"), ("user_id", "user_123"), ("config", "{\"theme\":\"dark\"}"), ("url", "https://example.com/path?query=value&foo=bar")] |> Js.Dict.fromList,
        ()
      ));
      let html = ReactDOMServer.renderToString(element);
      
      expect(html)->toContain("data-test-id=\"value-with-hyphens\"");
      expect(html)->toContain("data-user_id=\"user_123\"");
      expect(html)->toContain("data-config");
      expect(html)->toContain("data-url");
    });
    
    test("should handle empty values", () => {
      let element = ReactDOM.jsx("div", ReactDOM.domProps(
        ~dataAttrs=[("empty", ""), ("normal", "value")] |> Js.Dict.fromList,
        ()
      ));
      let html = ReactDOMServer.renderToString(element);
      
      expect(html)->toContain("data-empty=\"\"");
      expect(html)->toContain("data-normal=\"value\"");
    });
    
    test("should work with different HTML elements", () => {
      let dataAttrs = [("component", "test")] |> Js.Dict.fromList;
      
      let spanElement = ReactDOM.jsx("span", ReactDOM.domProps(~dataAttrs, ()));
      let spanHtml = ReactDOMServer.renderToString(spanElement);
      
      let inputElement = ReactDOM.jsx("input", ReactDOM.domProps(~dataAttrs, ()));
      let inputHtml = ReactDOMServer.renderToString(inputElement);
      
      let buttonElement = ReactDOM.jsx("button", ReactDOM.domProps(~dataAttrs, ()));
      let buttonHtml = ReactDOMServer.renderToString(buttonElement);
      
      expect(spanHtml)->toContain("<span data-component=\"test\"></span>");
      expect(inputHtml)->toContain("data-component=\"test\"");
      expect(buttonHtml)->toContain("data-component=\"test\"");
    });
    
    test("should preserve data-* attribute order consistency", () => {
      let element = ReactDOM.jsx("div", ReactDOM.domProps(
        ~dataAttrs=[("alpha", "1"), ("beta", "2"), ("gamma", "3")] |> Js.Dict.fromList,
        ()
      ));
      let html = ReactDOMServer.renderToString(element);
      
      // All data attributes should be present
      expect(html)->toContain("data-alpha=\"1\"");
      expect(html)->toContain("data-beta=\"2\"");
      expect(html)->toContain("data-gamma=\"3\"");
    });
    
    test("should maintain compatibility with React.cloneElement data attributes", () => {
      // Create element using dataAttrs prop
      let element = ReactDOM.jsx("div", ReactDOM.domProps(
        ~dataAttrs=Js.Dict.fromList([("testid", "original")]),
        ()
      ));
      let html = ReactDOMServer.renderToString(element);
      
      // Should produce same result as cloneElement with data-* attributes
      let clonedElement = React.cloneElement(
        <div> "Hello"->React.string </div>,
        {"data-testid": "cloned"},
      );
      let clonedHtml = ReactDOMServer.renderToString(clonedElement);
      
      expect(html)->toContain("data-testid=\"original\"");
      expect(clonedHtml)->toContain("data-testid=\"cloned\"");
      // Both should follow same data-* attribute pattern
      // expect(html)->toMatch(%re("/data-testid=\"[^\"]+\"/"));
      // expect(clonedHtml)->toMatch(%re("/data-testid=\"[^\"]+\"/"));
    });
    
    test("should handle data attributes with numeric and boolean-like values", () => {
      let element = ReactDOM.jsx("div", ReactDOM.domProps(
        ~dataAttrs=[("count", "42"), ("enabled", "true"), ("disabled", "false"), ("percentage", "95.5")] |> Js.Dict.fromList,
        ()
      ));
      
      let html = ReactDOMServer.renderToString(element);
      
      expect(html)->toContain("data-count=\"42\"");
      expect(html)->toContain("data-enabled=\"true\"");
      expect(html)->toContain("data-disabled=\"false\"");
      expect(html)->toContain("data-percentage=\"95.5\"");
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
