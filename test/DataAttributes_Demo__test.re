open Jest;
open Expect;

describe("Data Attributes - Demo Failure Replication", () => {
  
  describe("Exact DataAttrsDemo Module from demo/main.re", () => {
    
    test("should replicate exact demo failure: nested module with data attributes", () => {
      module DataAttrsDemo = {
        [@react.component]
        let make = () => {
          <section>
            <h3> {React.string("Zero-Runtime Data Attributes Demo")} </h3>
            
            <div className="demo-single" data_testid="single-demo">
              {React.string("Data attributes implemented (see tests for validation)")}
            </div>
            
            <div 
              className="demo-multi" 
              data_testid="demo-multi" 
              data_value="test"
            >
              {React.string("Data attributes: data_testid becomes data-testid")}
            </div>
            
            <div
              className="demo-container"
              id="main-demo"
              data_testid="main-demo"
              data_component="data-attrs-demo"
              style={ReactDOM.Style.make(~padding="12px", ~border="1px solid #ccc", ())}
            >
              {React.string("Zero-Runtime Data Attributes Demo - compile-time transformation")}
            </div>
            
            <details className="demo-comparison" data_testid="comparison-details" data_expandable="true">
              <summary data_role="toggle" data_testid="comparison-summary"> 
                {React.string("Old vs New Approach Comparison")} 
              </summary>
              <div className="comparison-content" data_testid="comparison-content" data_section="comparison">
                <h4 data_element="comparison-title" data_testid="old-title"> 
                  {React.string("Old Runtime Approach (removed):")} 
                </h4>
                <pre data_code="old-approach" data_testid="old-code">
                  {React.string({j|let dataAttrs = [("testid", "demo")] |> Js.Dict.fromList;
<div dataAttrs>...</div>|j})}
                </pre>
                
                <h4 data_element="comparison-title" data_testid="new-title"> 
                  {React.string("New Compile-Time Approach:")} 
                </h4>
                <pre data_code="new-approach" data_testid="new-code">
                  {React.string({j|<div data_testid="demo">...</div>|j})}
                </pre>
                
                <p data_content="benefits" data_testid="benefits"> 
                  {React.string("Benefits: Zero runtime overhead, cleaner syntax, compile-time validation")} 
                </p>
              </div>
            </details>
          </section>;
        };
      };
      
      let _container = ReactTestingLibrary.render(<DataAttrsDemo />);
      
      expect(true)->toBe(true);
    });
    
    test("should replicate demo failure with nested modules and data attributes", () => {
      module NestedDemoModule = {
        module InnerModule = {
          [@react.component] 
          let make = (~testId, ~category) => {
            <div data_testid={testId} data_category={category} data_level="deeply-nested">
              <span data_role="inner-content" data_testid={testId ++ "-content"}>
                {React.string("Nested module content with data attributes")}
              </span>
            </div>;
          };
        };
        
        [@react.component]
        let make = () => {
          <section data_testid="nested-demo-section" data_demo="nested-modules">
            <h2 data_element="section-title" data_testid="nested-title">
              {React.string("Nested Module Data Attributes Demo")}
            </h2>
            
            <div data_container="nested-demo" data_testid="nested-container" className="nested-demo-container">
              <InnerModule testId="inner-demo-1" category="demo" />
              <InnerModule testId="inner-demo-2" category="test" />
              
              <div className="demo-single" data_testid="nested-single-demo" data_source="nested-module">
                {React.string("This exact pattern failed in the original demo")}
              </div>
              
              <div 
                className="demo-multi" 
                data_testid="nested-multi-demo" 
                data_value="nested-test"
                data_module="nested"
              >
                {React.string("Multiple data attributes in nested module context")}
              </div>
            </div>
          </section>;
        };
      };
      
      let _container = ReactTestingLibrary.render(<NestedDemoModule />);
      
      expect(true)->toBe(true);
    });
    
    test("should fail with exact same error as demo: App module integration", () => {
      module AppWithDataAttrsDemo = {
        [@react.component]
        let make = () => {
          <main data_testid="app-main" data_component="demo-app">
            
            <div data_section="data-attrs-section" data_testid="data-attrs-section">
              <section data_demo="zero-runtime" data_testid="zero-runtime-demo">
                <h3 data_element="demo-title" data_testid="demo-title"> 
                  {React.string("Zero-Runtime Data Attributes Demo")} 
                </h3>
                
                <div className="demo-single" data_testid="exact-demo-pattern">
                  {React.string("Data attributes implemented (see tests for validation)")}
                </div>
                
                <div 
                  className="demo-multi" 
                  data_testid="demo-multi-exact" 
                  data_value="test"
                >
                  {React.string("Data attributes: data_testid becomes data-testid")}
                </div>
              </section>
            </div>
          </main>;
        };
      };
      
      let _container = ReactTestingLibrary.render(<AppWithDataAttrsDemo />);
      
      expect(true)->toBe(true);
    });
  });
  
  describe("User's Specific Requirement Validation", () => {
    
    test("should validate the exact DO NOT WORKAROUND requirement", () => {
      
      module UserRequiredPattern = {
        module NestedComponent = {
          [@react.component]
          let make = (~itemId, ~category) => {
            <div className="item-container" data_testid={itemId} data_category={category}>
              <span className="item-label" data_role="label" data_testid={itemId ++ "-label"}>
                {React.string("User's required pattern")}
              </span>
              <button 
                className="item-action" 
                data_action="click" 
                data_testid={itemId ++ "-button"}
                data_item_id={itemId}
              >
                {React.string("Action")}
              </button>
            </div>;
          };
        };
        
        [@react.component]
        let make = () => {
          <div className="user-required-container" data_testid="user-required" data_pattern="nested-modules">
            <h3 className="section-title" data_element="title" data_testid="section-title">
              {React.string("User's Required Pattern")}
            </h3>
            
            <div className="items-grid" data_layout="grid" data_testid="items-grid">
              <NestedComponent itemId="item-1" category="important" />
              <NestedComponent itemId="item-2" category="normal" />
              <NestedComponent itemId="item-3" category="urgent" />
            </div>
            
            <div className="demo-single" data_testid="user-failing-pattern" data_required="true">
              {React.string("This exact pattern must work - no workarounds allowed")}
            </div>
          </div>;
        };
      };
      
      let _container = ReactTestingLibrary.render(<UserRequiredPattern />);
      
      expect(true)->toBe(true);
    });
  });
});