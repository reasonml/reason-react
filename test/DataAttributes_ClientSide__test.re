open Jest;
open Expect;

external getAttribute: (Dom.element, string) => option(string) = "getAttribute";

let getByTestId = (testId, container) => {
  ReactTestingLibrary.getByTestId(~matcher=`Str(testId), container);
};

describe("Data Attributes - Client Side Compilation", () => {
  describe("PPX should generate valid client-side React component code", () => {
    
    test("should compile single data attribute on div element", () => {
      let container = ReactTestingLibrary.render(<div data_testid="test-element" />);
      let element = getByTestId("test-element", container);
      
      expect(element->getAttribute("data-testid"))->toEqual(Some("test-element"));
    });
    
    test("should compile multiple data attributes on same element", () => {
      let container = ReactTestingLibrary.render(<div data_testid="multi-attr-test" data_role="button" data_value="example" />);
      let element = getByTestId("multi-attr-test", container);
      
      expect(element->getAttribute("data-testid"))->toEqual(Some("multi-attr-test"));
      expect(element->getAttribute("data-role"))->toEqual(Some("button"));
      expect(element->getAttribute("data-value"))->toEqual(Some("example"));
    });
    
    test("should compile data attributes on different DOM elements", () => {
      let container = ReactTestingLibrary.render(
        <div>
          <div data_testid="div-test" />
          <span data_testid="span-test" data_role="span-role" />
          <button data_testid="button-test" data_analytics="button-analytics" />
          <input data_testid="input-test" data_field="input-field" />
        </div>
      );
      
      let divElement = getByTestId("div-test", container);
      let spanElement = getByTestId("span-test", container);
      let buttonElement = getByTestId("button-test", container);
      let inputElement = getByTestId("input-test", container);
      
      expect(divElement->getAttribute("data-testid"))->toEqual(Some("div-test"));
      expect(spanElement->getAttribute("data-role"))->toEqual(Some("span-role"));
      expect(buttonElement->getAttribute("data-analytics"))->toEqual(Some("button-analytics"));
      expect(inputElement->getAttribute("data-field"))->toEqual(Some("input-field"));
    });
    
    test("should compile data attributes in nested module context (original failure case)", () => {
      module TestModule = {
        [@react.component]
        let make = (~testProp) => {
          <div data_testid="nested-module-test" data_prop={testProp}>
            {React.string("Nested module with data attributes")}
          </div>;
        };
      };
      
      let container = ReactTestingLibrary.render(<TestModule testProp="example" />);
      let element = getByTestId("nested-module-test", container);
      
      expect(element->getAttribute("data-testid"))->toEqual(Some("nested-module-test"));
      expect(element->getAttribute("data-prop"))->toEqual(Some("example"));
      expect(DomTestingLibrary.getNodeText(element))->toBe("Nested module with data attributes");
    });
    
    test("should handle data attributes with underscores correctly", () => {
      let container = ReactTestingLibrary.render(<div data_testid="underscore-test" data_test_id="underscore" data_complex_name="value" />);
      let element = getByTestId("underscore-test", container);
      
      expect(element->getAttribute("data-test-id"))->toEqual(Some("underscore"));
      expect(element->getAttribute("data-complex-name"))->toEqual(Some("value"));
    });
    
    test("should compile data attributes alongside regular props", () => {
      let container = ReactTestingLibrary.render(
        <div 
          className="test-class" 
          id="test-id"
          data_testid="mixed-props" 
          data_analytics="track"
          style={ReactDOM.Style.make(~padding="10px", ())}
        >
          {React.string("Mixed props test")}
        </div>
      );
      let element = getByTestId("mixed-props", container);
      
      expect(element->getAttribute("data-testid"))->toEqual(Some("mixed-props"));
      expect(element->getAttribute("data-analytics"))->toEqual(Some("track"));
      expect(element->getAttribute("class"))->toEqual(Some("test-class"));
      expect(element->getAttribute("id"))->toEqual(Some("test-id"));
      expect(DomTestingLibrary.getNodeText(element))->toBe("Mixed props test");
    });
    
    test("should compile complex nested structure with data attributes", () => {
      let container = ReactTestingLibrary.render(
        <div data_testid="complex-container" data_container="outer">
          <span data_testid="inner-span" data_label="inner-label">
            {React.string("Nested content")}
          </span>
          <button data_testid="click-button" data_action="click-me" onClick={_ => Js.log("clicked")}>
            {React.string("Click")}
          </button>
          <input data_testid="user-input" data_field="input-field" placeholder="Type here" />
        </div>
      );
      
      let containerDiv = getByTestId("complex-container", container);
      let span = getByTestId("inner-span", container);
      let button = getByTestId("click-button", container);
      let input = getByTestId("user-input", container);
      
      expect(containerDiv->getAttribute("data-container"))->toEqual(Some("outer"));
      expect(span->getAttribute("data-label"))->toEqual(Some("inner-label"));
      expect(button->getAttribute("data-action"))->toEqual(Some("click-me"));
      expect(input->getAttribute("data-field"))->toEqual(Some("input-field"));
    });
    
    test("should work with React components containing data attributes", () => {
      module ComponentWithDataAttrs = {
        [@react.component]
        let make = (~label, ~value) => {
          <div data_testid="test-component" data_component="test-component" data_version="1.0">
            <h3 data_heading="component-title"> {React.string(label)} </h3>
            <p data_content="component-value"> {React.string(value)} </p>
          </div>;
        };
      };
      
      let container = ReactTestingLibrary.render(<ComponentWithDataAttrs label="Test" value="Content" />);
      let component = getByTestId("test-component", container);
      
      expect(component->getAttribute("data-component"))->toEqual(Some("test-component"));
      expect(component->getAttribute("data-version"))->toEqual(Some("1.0"));
    });
  });
  
  describe("Client-side React integration validation", () => {
    
    test("should render client-side component with data attributes", () => {
      module TestComponent = {
        [@react.component] 
        let make = () => {
          <div data_testid="client-render-test" data_framework="reason-react">
            {React.string("Client-side rendering test")}
          </div>;
        };
      };
      
      let container = ReactTestingLibrary.render(<TestComponent />);
      let element = getByTestId("client-render-test", container);
      
      expect(element->getAttribute("data-testid"))->toEqual(Some("client-render-test"));
      expect(element->getAttribute("data-framework"))->toEqual(Some("reason-react"));
      expect(DomTestingLibrary.getNodeText(element))->toBe("Client-side rendering test");
    });
  });
});