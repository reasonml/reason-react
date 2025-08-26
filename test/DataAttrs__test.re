open Jest;
open Expect;

describe("Data Attributes - Full Feature Validation", () => {
  test("comprehensive data attributes functionality", () => {
    // Test 1: Mixed data attributes with regular props
    let element1 = <div data_testid="my-test" data_custom="value" className="container" />;
    let html1 = ReactDOMServer.renderToString(element1);
    expect(html1)->toContain("data-testid=\"my-test\"");
    expect(html1)->toContain("data-custom=\"value\"");
    expect(html1)->toContain("class=\"container\"");

    // Test 2: Single data attribute
    let element2 = <div data_testid="foo" />;
    let html2 = ReactDOMServer.renderToString(element2);
    expect(html2)->toContain("data-testid=\"foo\"");

    // Test 3: Multiple data attributes on different elements
    let element3 = <button 
      data_testid="component-123" 
      data_role="button" 
      data_index="5" 
      data_active="true" 
      data_disabled="false" 
    />;
    let html3 = ReactDOMServer.renderToString(element3);
    expect(html3)->toContain("data-testid=\"component-123\"");
    expect(html3)->toContain("data-role=\"button\"");
    expect(html3)->toContain("data-index=\"5\"");
    expect(html3)->toContain("data-active=\"true\"");
    expect(html3)->toContain("data-disabled=\"false\"");

    // Test 4: Special characters in values
    let element4 = <div data_config="{\"theme\":\"dark\"}" data_url="https://example.com/test" />;
    let html4 = ReactDOMServer.renderToString(element4);
    expect(html4)->toContain("data-config");
    expect(html4)->toContain("data-url");

    // Test 5: Different HTML elements
    let spanElement = <span data_component="test" />;
    let spanHtml = ReactDOMServer.renderToString(spanElement);
    expect(spanHtml)->toEqual("<span data-component=\"test\"></span>");

    let inputElement = <input data_component="input" />;
    let inputHtml = ReactDOMServer.renderToString(inputElement);
    expect(inputHtml)->toContain("data-component=\"input\"");

    // Test 6: Empty values
    let element5 = <div data_empty="" data_normal="value" />;
    let html5 = ReactDOMServer.renderToString(element5);
    expect(html5)->toContain("data-empty=\"\"");
    expect(html5)->toContain("data-normal=\"value\"");
  });
  
  test("kebab-case conversion validation", () => {
    // Verify that data_testid becomes data-testid, etc.
    let element = <div data_test_id="kebab" data_user_name="john" data_item_count="5" />;
    let html = ReactDOMServer.renderToString(element);
    
    expect(html)->toContain("data-test-id=\"kebab\"");
    expect(html)->toContain("data-user-name=\"john\"");
    expect(html)->toContain("data-item-count=\"5\"");
    
    // Verify exact output
    expect(html)->toEqual("<div data-test-id=\"kebab\" data-user-name=\"john\" data-item-count=\"5\"></div>");
  });
});