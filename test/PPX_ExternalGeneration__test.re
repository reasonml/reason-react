open Jest;
open Expect;

describe("PPX External Declaration Generation", () => {
  describe("External declarations for data attributes", () => {
    
    test("should fail compilation due to missing external makeProps_div_* declarations", () => {
      let _testElement1 = <div data_testid="test" />;
      
      expect(Js.typeof(_testElement1))->toBe("object");
    });
    
    test("should fail compilation for kebab-case data attributes", () => {
      let _testElement = <div data_test_id="underscore" />;
      
      expect(Js.typeof(_testElement))->toBe("object");
    });
    
    test("should fail compilation for different element types with data attributes", () => {
      let _divElement = <div data_testid="div-test" />;
      let _spanElement = <span data_role="span-test" />;
      let _buttonElement = <button data_analytics="button-test" />;
      
      expect(Js.typeof(_divElement))->toBe("object");
      expect(Js.typeof(_spanElement))->toBe("object");
      expect(Js.typeof(_buttonElement))->toBe("object");
    });
    
    test("should fail compilation with deduplication issue for same data attributes", () => {
      let _element1 = <div data_testid="test1" />;
      let _element2 = <div data_testid="test2" />;
      let _element3 = <div data_testid="test3" />;
      
      expect(Js.typeof(_element1))->toBe("object");
      expect(Js.typeof(_element2))->toBe("object");
      expect(Js.typeof(_element3))->toBe("object");
    });
    
    test("should fail compilation for elements with multiple data attributes", () => {
      let _element = <div data_testid="test" data_role="button" data_value="example" />;
      
      expect(Js.typeof(_element))->toBe("object");
    });
    
    test("should fail compilation for components with data attributes in modules", () => {
      module TestComponent = {
        [@react.component]
        let make = (~testProp) => {
          <div data_component="test" data_prop={testProp}>
            {React.string("Test component")}
          </div>;
        };
      };
      
      let _component = <TestComponent testProp="value" />;
      
      expect(Js.typeof(_component))->toBe("object");
    });
  });
  
  describe("PPX external generation integration", () => {
    test("should fail compilation when externals are missing (core issue)", () => {
      
      let _element1 = <div data_testid="callable-test-1" />;
      let _element2 = <span data_role="callable-test-2" />;
      let _element3 = <button data_analytics="callable-test-3" />;
      
      expect(Js.typeof(_element1))->toBe("object");
      expect(Js.typeof(_element2))->toBe("object");
      expect(Js.typeof(_element3))->toBe("object");
    });
    
    testAsync("should fail compilation for async components with data attributes", finish => {
      module RenderTest = {
        [@react.component]
        let make = () => {
          React.useEffect0(() => {
            finish();
            None;
          });
          
          <div data_testid="render-integration" data_framework="reason-react">
            {React.string("Integration test")}
          </div>;
        };
      };
      
      let _component = <RenderTest />;
      ();
    });
  });
});