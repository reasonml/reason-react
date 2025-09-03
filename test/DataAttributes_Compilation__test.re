open Jest;
open Expect;

[@mel.send]
external getAttribute: (Dom.element, string) => option(string) =
  "getAttribute";

let getByTestId = (testId, container) => {
  ReactTestingLibrary.getByTestId(~matcher=`Str(testId), container);
};

type requestStatus =
  | Loading
  | Success(string)
  | Error(string);

describe("Data Attributes - PPX Compilation Tests", () => {
  describe("Basic data attribute compilation", () => {
    test(
      "should compile data attributes on various element types with proper transformations",
      () => {
        let container =
          ReactTestingLibrary.render(
            <div>
              <div data_testid="single-test" />
              <span
                data_testid="multi-test"
                data_role="content"
                data_value="example"
              />
              <button
                data_testid="button-test"
                data_analytics="click-tracking"
              />
              <input data_testid="input-test" data_field="user-input" />
              <header data_testid="header-test" data_section="navigation" />
              <div
                data_testid="kebab-test"
                data_test_id="underscore"
                data_complex_name="camelCase"
              />
            </div>,
          );

        // Test single attribute
        let singleElement = getByTestId("single-test", container);
        expect(singleElement->getAttribute("data-testid"))
        ->toEqual(Some("single-test"));

        // Test multiple attributes
        let multiElement = getByTestId("multi-test", container);
        expect(multiElement->getAttribute("data-testid"))
        ->toEqual(Some("multi-test"));
        expect(multiElement->getAttribute("data-role"))
        ->toEqual(Some("content"));
        expect(multiElement->getAttribute("data-value"))
        ->toEqual(Some("example"));

        // Test different element types
        let buttonElement = getByTestId("button-test", container);
        let inputElement = getByTestId("input-test", container);
        let headerElement = getByTestId("header-test", container);
        expect(buttonElement->getAttribute("data-analytics"))
        ->toEqual(Some("click-tracking"));
        expect(inputElement->getAttribute("data-field"))
        ->toEqual(Some("user-input"));
        expect(headerElement->getAttribute("data-section"))
        ->toEqual(Some("navigation"));

        // Test underscore to kebab-case transformation
        let kebabElement = getByTestId("kebab-test", container);
        expect(kebabElement->getAttribute("data-test-id"))
        ->toEqual(Some("underscore"));
        expect(kebabElement->getAttribute("data-complex-name"))
        ->toEqual(Some("camelCase"));
      },
    );

    test("should compile data attributes alongside standard props", () => {
      let container =
        ReactTestingLibrary.render(
          <div
            className="test-class"
            id="test-id"
            data_testid="mixed-props"
            data_component="test-component"
            style={ReactDOM.Style.make(
              ~padding="12px",
              ~border="1px solid #ccc",
              (),
            )}>
            {React.string("Mixed props test")}
          </div>,
        );

      let element = getByTestId("mixed-props", container);
      expect(element->getAttribute("data-testid"))
      ->toEqual(Some("mixed-props"));
      expect(element->getAttribute("data-component"))
      ->toEqual(Some("test-component"));
      expect(element->getAttribute("class"))->toEqual(Some("test-class"));
      expect(element->getAttribute("id"))->toEqual(Some("test-id"));
      expect(DomTestingLibrary.getNodeText(element))
      ->toBe("Mixed props test");
    });
  });

  describe("Dynamic values and expressions", () => {
    test(
      "should handle dynamic values, expressions, and string operations", () => {
      let testId = "dynamic-test";
      let category = "user-action";
      let userId = "123";
      let prefix = "user";
      let isActive = true;
      let count = 42;

      let container =
        ReactTestingLibrary.render(
          <div>
            <div
              data_testid=testId data_category=category data_priority="high">
              {React.string("Variable assignments")}
            </div>
            <span
              data_testid={prefix ++ "-" ++ userId ++ "-profile"}
              data_status={isActive ? "active" : "inactive"}
              data_count={string_of_int(count)}>
              {React.string("Expressions")}
            </span>
          </div>,
        );

      // Test variable assignments
      let dynamicElement = getByTestId("dynamic-test", container);
      expect(dynamicElement->getAttribute("data-testid"))
      ->toEqual(Some("dynamic-test"));
      expect(dynamicElement->getAttribute("data-category"))
      ->toEqual(Some("user-action"));
      expect(dynamicElement->getAttribute("data-priority"))
      ->toEqual(Some("high"));

      // Test expressions
      let expressionElement = getByTestId("user-123-profile", container);
      expect(expressionElement->getAttribute("data-testid"))
      ->toEqual(Some("user-123-profile"));
      expect(expressionElement->getAttribute("data-status"))
      ->toEqual(Some("active"));
      expect(expressionElement->getAttribute("data-count"))
      ->toEqual(Some("42"));
    });

    test("should handle function results and pattern matching", () => {
      let getEnvironment = () => "development";
      let calculateScore = (a, b) => string_of_int(a + b);
      let items = [1, 2, 3];
      let currentStatus = Success("Data loaded successfully");

      let getStatusString = (status: requestStatus) =>
        switch (status) {
        | Loading => "loading"
        | Success(_) => "success"
        | Error(_) => "error"
        };

      let getStatusMessage = (status: requestStatus) =>
        switch (status) {
        | Loading => "Please wait..."
        | Success(msg) => msg
        | Error(err) => "Error: " ++ err
        };

      let container =
        ReactTestingLibrary.render(
          <div>
            <div
              data_testid="function-results"
              data_env={getEnvironment()}
              data_score={calculateScore(15, 27)}
              data_length={string_of_int(List.length(items))}>
              {React.string("Function results")}
            </div>
            <div
              data_testid="pattern-matching"
              data_status={getStatusString(currentStatus)}
              data_message={getStatusMessage(currentStatus)}>
              {React.string("Pattern matching")}
            </div>
          </div>,
        );

      // Test function results
      let functionElement = getByTestId("function-results", container);
      expect(functionElement->getAttribute("data-env"))
      ->toEqual(Some("development"));
      expect(functionElement->getAttribute("data-score"))
      ->toEqual(Some("42"));
      expect(functionElement->getAttribute("data-length"))
      ->toEqual(Some("3"));

      // Test pattern matching
      let patternElement = getByTestId("pattern-matching", container);
      expect(patternElement->getAttribute("data-status"))
      ->toEqual(Some("success"));
      expect(patternElement->getAttribute("data-message"))
      ->toEqual(Some("Data loaded successfully"));
    });
  });

  describe("Nested modules and component compilation", () => {
    test("should compile data attributes in nested module contexts", () => {
      module OuterModule = {
        module InnerModule = {
          [@react.component]
          let make = (~testId, ~category) => {
            <div
              data_testid=testId
              data_category=category
              data_level="deeply-nested">
              <span
                data_role="inner-content" data_testid={testId ++ "-content"}>
                {React.string("Nested module content")}
              </span>
            </div>;
          };
        };

        [@react.component]
        let make = (~testProp) => {
          <section data_testid="outer-module" data_component="nested-test">
            <h2 data_element="title" data_testid="module-title">
              {React.string("Nested Module Test")}
            </h2>
            <InnerModule testId="inner-test" category="demo" />
            <div data_testid="module-content" data_prop=testProp>
              {React.string("Module with prop: " ++ testProp)}
            </div>
          </section>;
        };
      };

      let container =
        ReactTestingLibrary.render(<OuterModule testProp="test-value" />);

      // Test outer module
      let outerElement = getByTestId("outer-module", container);
      expect(outerElement->getAttribute("data-component"))
      ->toEqual(Some("nested-test"));

      // Test inner module
      let innerElement = getByTestId("inner-test", container);
      expect(innerElement->getAttribute("data-category"))
      ->toEqual(Some("demo"));
      expect(innerElement->getAttribute("data-level"))
      ->toEqual(Some("deeply-nested"));

      // Test nested content
      let contentElement = getByTestId("inner-test-content", container);
      expect(contentElement->getAttribute("data-role"))
      ->toEqual(Some("inner-content"));

      // Test prop passing
      let moduleContent = getByTestId("module-content", container);
      expect(moduleContent->getAttribute("data-prop"))
      ->toEqual(Some("test-value"));
    });

    test(
      "should handle complex nested structures with mixed element types", () => {
      let container =
        ReactTestingLibrary.render(
          <main data_testid="complex-structure" data_component="demo-app">
            <header data_role="app-header" data_testid="app-header">
              <h1 data_element="app-title">
                {React.string("Complex Structure Test")}
              </h1>
            </header>
            <section data_section="content" data_testid="content-section">
              <div data_container="form" data_testid="form-container">
                <form data_testid="test-form" data_validation="required">
                  <label data_element="form-label" data_for="test-input">
                    {React.string("Test Input:")}
                  </label>
                  <input
                    data_testid="test-input"
                    data_field="user-data"
                    data_validation="text"
                    placeholder="Enter text"
                  />
                  <button
                    data_testid="submit-button"
                    data_action="form-submit"
                    data_analytics="click-tracking"
                    type_="button">
                    {React.string("Submit")}
                  </button>
                </form>
              </div>
            </section>
            <footer data_role="app-footer" data_testid="app-footer">
              <p data_content="footer-text">
                {React.string("Complex structure demo")}
              </p>
            </footer>
          </main>,
        );

      // Test various elements in complex structure
      let mainElement = getByTestId("complex-structure", container);
      let headerElement = getByTestId("app-header", container);
      let formElement = getByTestId("test-form", container);
      let inputElement = getByTestId("test-input", container);
      let buttonElement = getByTestId("submit-button", container);
      let footerElement = getByTestId("app-footer", container);

      expect(mainElement->getAttribute("data-component"))
      ->toEqual(Some("demo-app"));
      expect(headerElement->getAttribute("data-role"))
      ->toEqual(Some("app-header"));
      expect(formElement->getAttribute("data-validation"))
      ->toEqual(Some("required"));
      expect(inputElement->getAttribute("data-field"))
      ->toEqual(Some("user-data"));
      expect(buttonElement->getAttribute("data-action"))
      ->toEqual(Some("form-submit"));
      expect(footerElement->getAttribute("data-role"))
      ->toEqual(Some("app-footer"));
    });
  });

  describe("Data attribute deduplication and reuse", () => {
    test(
      "should handle same data attributes used multiple times without conflicts",
      () => {
      let sharedCategory = "test-category";

      let container =
        ReactTestingLibrary.render(
          <div data_testid="deduplication-test" data_category=sharedCategory>
            <div
              data_testid="item-1" data_category=sharedCategory data_index="1">
              {React.string("Item 1")}
            </div>
            <div
              data_testid="item-2" data_category=sharedCategory data_index="2">
              {React.string("Item 2")}
            </div>
            <div
              data_testid="item-3" data_category=sharedCategory data_index="3">
              {React.string("Item 3")}
            </div>
            <span data_testid="different-element" data_category=sharedCategory>
              {React.string("Different element type")}
            </span>
          </div>,
        );

      let parentElement = getByTestId("deduplication-test", container);
      let item1 = getByTestId("item-1", container);
      let item2 = getByTestId("item-2", container);
      let item3 = getByTestId("item-3", container);
      let spanElement = getByTestId("different-element", container);

      // All elements should have the same category attribute
      expect(parentElement->getAttribute("data-category"))
      ->toEqual(Some("test-category"));
      expect(item1->getAttribute("data-category"))
      ->toEqual(Some("test-category"));
      expect(item2->getAttribute("data-category"))
      ->toEqual(Some("test-category"));
      expect(item3->getAttribute("data-category"))
      ->toEqual(Some("test-category"));
      expect(spanElement->getAttribute("data-category"))
      ->toEqual(Some("test-category"));

      // Unique attributes should work correctly
      expect(item1->getAttribute("data-index"))->toEqual(Some("1"));
      expect(item2->getAttribute("data-index"))->toEqual(Some("2"));
      expect(item3->getAttribute("data-index"))->toEqual(Some("3"));
    })
  });
});
