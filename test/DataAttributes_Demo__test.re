/* 
 * FAILING DEMO TEST FILE: DataAttributes_Demo__test.re
 * 
 * PURPOSE: This test replicates the EXACT demo failure scenario from demo/main.re
 *          It tests the specific user requirement: data attributes in nested modules.
 * 
 * EXPECTED FAILURE: "Error: Unbound value makeProps_div_*" compilation errors
 * exactly as experienced in the original demo when running `make test`
 * 
 * CRITICAL: This test must fail with the same compilation error as the demo:
 * "Error: Unbound value makeProps_div_85595cb5" (or similar hash)
 * 
 * DEMO PATTERN REPLICATION:
 * - Exact DataAttrsDemo module structure from demo/main.re
 * - Same JSX patterns that were failing in nested modules
 * - Same props combinations (className + data attributes)
 * - Same nested module context causing the original issues
 * 
 * USER REQUIREMENT VALIDATION:
 * This validates the "DO NOT DO THE WORKAROUND. THIS IS REQUIRED TO WORK" scenario
 * where data attributes must work inside nested modules exactly as shown in the demo.
 */

open Jest;
open Expect;

// Note: This test focuses on compilation failure, not runtime testing
// The key point is that data attributes in nested modules cause "Unbound value makeProps_*" errors

describe("Data Attributes - Demo Failure Replication", () => {
  
  describe("Exact DataAttrsDemo Module from demo/main.re", () => {
    
    // CRITICAL: This replicates the EXACT DataAttrsDemo module that was failing in demo/main.re
    test("should replicate exact demo failure: nested module with data attributes", () => {
      // EXACT COPY of DataAttrsDemo module from demo/main.re with data attributes added
      // This MUST fail with "Unbound value makeProps_div_*" compilation errors
      module DataAttrsDemo = {
        [@react.component]
        let make = () => {
          // EXPECTED FAILURE: These elements should cause the exact same compilation errors
          // as experienced in the original demo scenario
          <section>
            <h3> {React.string("Zero-Runtime Data Attributes Demo")} </h3>
            
            // CRITICAL FAILURE POINT: This was the exact pattern that failed in the demo
            // The user specifically reported this className + data_testid combination failing
            <div className="demo-single" data_testid="single-demo">
              {React.string("Data attributes implemented (see tests for validation)")}
            </div>
            
            // EXPECTED FAILURE: Multiple data attributes on same element in nested module
            <div 
              className="demo-multi" 
              data_testid="demo-multi" 
              data_value="test"
            >
              {React.string("Data attributes: data_testid becomes data-testid")}
            </div>
            
            // EXPECTED FAILURE: Complex props + data attributes combination
            <div
              className="demo-container"
              id="main-demo"
              data_testid="main-demo"
              data_component="data-attrs-demo"
              style={ReactDOM.Style.make(~padding="12px", ~border="1px solid #ccc", ())}
            >
              {React.string("Zero-Runtime Data Attributes Demo - compile-time transformation")}
            </div>
            
            // EXPECTED FAILURE: Nested elements with data attributes inside nested module
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
      
      // EXPECTED FAILURE: This render call should fail to compile due to missing external declarations
      // The exact same error the user encountered: "Error: Unbound value makeProps_div_[hash]"
      let _container = ReactTestingLibrary.render(<DataAttrsDemo />);
      
      // This test's purpose is to fail during compilation, proving that:
      // 1. Data attributes in nested modules cause the exact same error as the demo
      // 2. The user's requirement (data attrs in nested modules) currently doesn't work 
      // 3. Once PPX generates external declarations, this test should compile and pass
      expect(true)->toBe(true); // Placeholder - real validation is at compile time
    });
    
    test("should replicate demo failure with nested modules and data attributes", () => {
      // This tests the specific nested module scenario that was causing the original compilation failure
      module NestedDemoModule = {
        module InnerModule = {
          [@react.component] 
          let make = (~testId, ~category) => {
            // EXPECTED FAILURE: Deeply nested module with data attributes
            // This replicates the exact nesting pattern that was failing in the demo
            <div data_testid={testId} data_category={category} data_level="deeply-nested">
              <span data_role="inner-content" data_testid={testId ++ "-content"}>
                {React.string("Nested module content with data attributes")}
              </span>
            </div>;
          };
        };
        
        [@react.component]
        let make = () => {
          // EXPECTED FAILURE: This should fail exactly as the demo failed
          // Testing the same nested module structure with data attributes
          <section data_testid="nested-demo-section" data_demo="nested-modules">
            <h2 data_element="section-title" data_testid="nested-title">
              {React.string("Nested Module Data Attributes Demo")}
            </h2>
            
            <div data_container="nested-demo" data_testid="nested-container" className="nested-demo-container">
              <InnerModule testId="inner-demo-1" category="demo" />
              <InnerModule testId="inner-demo-2" category="test" />
              
              // CRITICAL: This exact pattern was failing in the original demo
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
      
      // EXPECTED FAILURE: Same compilation error as the original demo
      let _container = ReactTestingLibrary.render(<NestedDemoModule />);
      
      // The purpose of this test is compilation failure validation
      // Once PPX is fixed, this will compile and the test will pass
      expect(true)->toBe(true); // Placeholder - real validation is at compile time
    });
    
    test("should fail with exact same error as demo: App module integration", () => {
      // This replicates how DataAttrsDemo was integrated into the App module in demo/main.re
      module AppWithDataAttrsDemo = {
        [@react.component]
        let make = () => {
          // Simulate the App module structure from demo/main.re
          <main data_testid="app-main" data_component="demo-app">
            // Other demo components would go here...
            
            // CRITICAL: This is the exact integration pattern that was failing
            // The DataAttrsDemo module inside the App module context
            <div data_section="data-attrs-section" data_testid="data-attrs-section">
              // Replicate the exact demo structure that was causing compilation errors
              <section data_demo="zero-runtime" data_testid="zero-runtime-demo">
                <h3 data_element="demo-title" data_testid="demo-title"> 
                  {React.string("Zero-Runtime Data Attributes Demo")} 
                </h3>
                
                // EXACT FAILING PATTERN from demo/main.re line 232-234
                <div className="demo-single" data_testid="exact-demo-pattern">
                  {React.string("Data attributes implemented (see tests for validation)")}
                </div>
                
                // EXACT FAILING PATTERN from demo/main.re line 236-240  
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
      
      // EXPECTED FAILURE: This should produce the exact same compilation error
      // as when the user tried to use <DataAttrsDemo key="data-attrs-demo" /> in demo/main.re
      let _container = ReactTestingLibrary.render(<AppWithDataAttrsDemo />);
      
      // The purpose is to replicate the exact demo integration failure
      // Once PPX is fixed, this will compile successfully
      expect(true)->toBe(true); // Placeholder - real validation is at compile time
    });
  });
  
  describe("User's Specific Requirement Validation", () => {
    
    test("should validate the exact DO NOT WORKAROUND requirement", () => {
      // This test validates the user's exact requirement:
      // "DO NOT DO THE WORKAROUND. THIS IS REQUIRED TO WORK"
      // Testing data attributes in nested modules exactly as the user needs them
      
      module UserRequiredPattern = {
        module NestedComponent = {
          [@react.component]
          let make = (~itemId, ~category) => {
            // USER'S EXACT REQUIREMENT: This pattern must work without workarounds
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
          // EXPECTED FAILURE: This exact pattern the user needs must work
          <div className="user-required-container" data_testid="user-required" data_pattern="nested-modules">
            <h3 className="section-title" data_element="title" data_testid="section-title">
              {React.string("User's Required Pattern")}
            </h3>
            
            <div className="items-grid" data_layout="grid" data_testid="items-grid">
              <NestedComponent itemId="item-1" category="important" />
              <NestedComponent itemId="item-2" category="normal" />
              <NestedComponent itemId="item-3" category="urgent" />
            </div>
            
            // The user's specific failing case: className + data attributes in nested module
            <div className="demo-single" data_testid="user-failing-pattern" data_required="true">
              {React.string("This exact pattern must work - no workarounds allowed")}
            </div>
          </div>;
        };
      };
      
      // EXPECTED FAILURE: User's exact requirement should fail with compilation error
      let _container = ReactTestingLibrary.render(<UserRequiredPattern />);
      
      // This validates the user's "DO NOT DO THE WORKAROUND" requirement
      // The test must fail to compile, proving the issue exists
      // Once PPX is fixed, this will compile and pass
      expect(true)->toBe(true); // Placeholder - real validation is at compile time
    });
  });
});