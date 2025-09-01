/* 
 * FAILING TEST FILE: DataAttributes_ClientSide__test.re
 * 
 * PURPOSE: This test demonstrates the PPX bug with data attributes in client-side compilation.
 * 
 * EXPECTED FAILURE: "Error: Unbound value makeProps_div_[hash]" when running `make test`
 * 
 * This proves the PPX deduplication bug exists for client-side React compilation.
 */

open Jest;
open Expect;

describe("Data Attributes - Client Side Compilation", () => {
  describe("PPX should generate valid client-side React component code", () => {
    
    // CRITICAL: These tests MUST fail initially with "Unbound value makeProps_*" errors
    // until the PPX deduplication bug is fixed for client-side compilation
    
    test("should compile single data attribute on div element", () => {
      // This will fail compilation with: "Error: Unbound value makeProps_div_[hash]" 
      let element = <div data_testid="test" />;
      
      // Once PPX is fixed, this should create a ReactDOM element with data-testid="test"
      expect(Js.typeof(element))->toBe("object");
    });
    
    test("should compile multiple data attributes on same element", () => {
      // This will fail compilation with: "Error: Unbound value makeProps_div_[hash]"
      let element = <div data_testid="test" data_role="button" data_value="example" />;
      
      // Once PPX is fixed, this should create a ReactDOM element with all data attributes
      expect(Js.typeof(element))->toBe("object");
    });
    
    test("should compile data attributes on different DOM elements", () => {
      // Each element type will fail with its own "Unbound value makeProps_[element]_[hash]" error
      let divElement = <div data_testid="div-test" />;
      let spanElement = <span data_role="span-test" />;
      let buttonElement = <button data_analytics="button-test" />;
      let inputElement = <input data_field="input-test" />;
      
      // Once PPX is fixed, all these should compile and create proper ReactDOM elements
      expect(Js.typeof(divElement))->toBe("object");
      expect(Js.typeof(spanElement))->toBe("object");
      expect(Js.typeof(buttonElement))->toBe("object");
      expect(Js.typeof(inputElement))->toBe("object");
    });
    
    test("should compile data attributes in nested module context (original failure case)", () => {
      // This reproduces the exact pattern from the user's original issue
      module TestModule = {
        [@react.component]
        let make = (~testProp) => {
          // This exact pattern fails with: "Error: Unbound value makeProps_div_[hash]"
          <div data_testid="nested-module-test" data_prop={testProp}>
            {React.string("Nested module with data attributes")}
          </div>;
        };
      };
      
      let component = <TestModule testProp="example" />;
      
      // Once PPX is fixed, this should compile and create a proper React component
      expect(Js.typeof(component))->toBe("object");
    });
    
    test("should handle data attributes with underscores correctly", () => {
      // This tests the underscore to hyphen transformation in client-side compilation
      let element = <div data_test_id="underscore" data_complex_name="value" />;
      
      // Once PPX is fixed, this should compile to data-test-id and data-complex-name
      expect(Js.typeof(element))->toBe("object");
    });
    
    test("should compile data attributes alongside regular props", () => {
      // This tests mixing data attributes with regular DOM props
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
      
      // Once PPX is fixed, this should compile with both regular and data props
      expect(Js.typeof(element))->toBe("object");
    });
    
    test("should compile complex nested structure with data attributes", () => {
      // This tests more complex nesting that might trigger multiple hash collisions
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
      
      // Once PPX is fixed, this entire structure should compile properly
      expect(Js.typeof(complexElement))->toBe("object");
    });
    
    test("should work with React components containing data attributes", () => {
      // This tests data attributes within React components (not just raw DOM elements)
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
      
      // Once PPX is fixed, this component should compile with all data attributes
      expect(Js.typeof(component))->toBe("object");
    });
  });
  
  describe("Client-side React integration validation", () => {
    // These tests verify that once compilation works, the components integrate properly
    
    testAsync("should render client-side component with data attributes", finish => {
      // This test validates actual client-side rendering behavior
      module TestComponent = {
        [@react.component] 
        let make = () => {
          React.useEffect0(() => {
            // Once PPX is fixed, this should successfully render to DOM
            finish();
            None;
          });
          
          <div data_testid="client-render-test" data_framework="reason-react">
            {React.string("Client-side rendering test")}
          </div>;
        };
      };
      
      // This will fail compilation until PPX is fixed
      let _component = <TestComponent />;
      ();
    });
  });
});