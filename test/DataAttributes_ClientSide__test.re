open Jest;
open Expect;

describe("Data Attributes - Client Side Compilation", () => {
  describe("PPX should generate valid client-side React component code", () => {
    
    test("should compile single data attribute on div element", () => {
      let element = <div data_testid="test" />;
      
      expect(Js.typeof(element))->toBe("object");
    });
    
    test("should compile multiple data attributes on same element", () => {
      let element = <div data_testid="test" data_role="button" data_value="example" />;
      
      expect(Js.typeof(element))->toBe("object");
    });
    
    test("should compile data attributes on different DOM elements", () => {
      let divElement = <div data_testid="div-test" />;
      let spanElement = <span data_role="span-test" />;
      let buttonElement = <button data_analytics="button-test" />;
      let inputElement = <input data_field="input-test" />;
      
      expect(Js.typeof(divElement))->toBe("object");
      expect(Js.typeof(spanElement))->toBe("object");
      expect(Js.typeof(buttonElement))->toBe("object");
      expect(Js.typeof(inputElement))->toBe("object");
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
      
      let component = <TestModule testProp="example" />;
      
      expect(Js.typeof(component))->toBe("object");
    });
    
    test("should handle data attributes with underscores correctly", () => {
      let element = <div data_test_id="underscore" data_complex_name="value" />;
      
      expect(Js.typeof(element))->toBe("object");
    });
    
    test("should compile data attributes alongside regular props", () => {
      let element = 
        <div 
          className="test-class" 
          id="test-id"
          data_testid="mixed-props" 
          data_analytics="track"
          style={ReactDOM.Style.make(~padding="10px", ())}
        >
          {React.string("Mixed props test")}
        </div>;
      
      expect(Js.typeof(element))->toBe("object");
    });
    
    test("should compile complex nested structure with data attributes", () => {
      let complexElement = 
        <div data_container="outer">
          <span data_label="inner-span">
            {React.string("Nested content")}
          </span>
          <button data_action="click-me" onClick={_ => Js.log("clicked")}>
            {React.string("Click")}
          </button>
          <input data_field="user-input" placeholder="Type here" />
        </div>;
      
      expect(Js.typeof(complexElement))->toBe("object");
    });
    
    test("should work with React components containing data attributes", () => {
      module ComponentWithDataAttrs = {
        [@react.component]
        let make = (~label, ~value) => {
          <div data_component="test-component" data_version="1.0">
            <h3 data_heading="component-title"> {React.string(label)} </h3>
            <p data_content="component-value"> {React.string(value)} </p>
          </div>;
        };
      };
      
      let component = <ComponentWithDataAttrs label="Test" value="Content" />;
      
      expect(Js.typeof(component))->toBe("object");
    });
  });
  
  describe("Client-side React integration validation", () => {
    
    testAsync("should render client-side component with data attributes", finish => {
      module TestComponent = {
        [@react.component] 
        let make = () => {
          React.useEffect0(() => {
            finish();
            None;
          });
          
          <div data_testid="client-render-test" data_framework="reason-react">
            {React.string("Client-side rendering test")}
          </div>;
        };
      };
      
      let _component = <TestComponent />;
      ();
    });
  });
});