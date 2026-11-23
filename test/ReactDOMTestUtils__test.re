[@alert "-deprecated"];

open Jest;
open Jest.Expect;

external document: Dom.document = "document";
[@mel.send]
external createElement: (Dom.document, string) => Dom.element =
  "createElement";
[@mel.set] external setInnerHTML: (Dom.element, string) => unit = "innerHTML";
[@mel.send]
external querySelector: (Dom.element, string) => Dom.element = "querySelector";

describe("DOM text queries", () => {
  let container = document->createElement("div");
  container->setInnerHTML(
    "<span id='first'>Hello café</span><span>Hello café again</span>",
  );
  let first = container->querySelector("#first");

  test("it finds exact text and the first partial match", () => {
    let exact =
      ReactDOMTestUtils.DOM.findBySelectorAndTextContent(
        container,
        "span",
        "Hello café",
      );
    let partial =
      ReactDOMTestUtils.DOM.findBySelectorAndPartialTextContent(
        container,
        "span",
        "café",
      );
    expect(Option.get(exact))->toBe(first);
    expect(Option.get(partial))->toBe(first);
  });

  test("it returns None when no element or text matches", () => {
    List.iter(
      ((selector, content)) => {
        expect(
          ReactDOMTestUtils.DOM.findBySelectorAndTextContent(
            container,
            selector,
            content,
          ),
        )
        ->toEqual(None);
        expect(
          ReactDOMTestUtils.DOM.findBySelectorAndPartialTextContent(
            container,
            selector,
            content,
          ),
        )
        ->toEqual(None);
      },
      [("span", "absent"), (".missing", "Hello café")],
    )
  });
});
