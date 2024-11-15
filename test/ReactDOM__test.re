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
