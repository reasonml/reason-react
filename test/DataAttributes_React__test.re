open Jest;
open Expect;

[@mel.send]
external getAttribute: (Dom.element, string) => option(string) = "getAttribute";

let getByTestId = (testId, container) => {
  ReactTestingLibrary.getByTestId(~matcher=`Str(testId), container);
};

describe("Data Attributes - React Integration Tests", () => {
  describe("React hooks and state integration", () => {
    test("should integrate data attributes with React hooks and dynamic state", () => {
      module HooksIntegrationComponent = {
        [@react.component]
        let make = (~initialCount=0) => {
          let (count, setCount) = React.useState(() => initialCount);
          let (status, setStatus) = React.useState(() => "idle");
          let (data, setData) = React.useState(() => "");
          
          // useEffect to simulate async operation
          React.useEffect1(() => {
            if (count > 0) {
              setStatus(_ => "active");
              setData(_ => "Count is " ++ string_of_int(count));
            } else {
              setStatus(_ => "idle");
              setData(_ => "No data");
            }
            None;
          }, [|count|]);
          
          <div data_testid="hooks-integration" data_component="counter" data_status={status}>
            <div data_role="status-display" data_testid="status-display">
              {React.string("Status: " ++ status)}
            </div>
            
            <div data_content="counter-data" data_testid="counter-data">
              {React.string(data)}
            </div>
            
            <button
              data_testid="increment-btn"
              data_action="increment"
              data_current_count={string_of_int(count)}
              onClick={_ => setCount(prev => prev + 1)}
            >
              {React.string("Count: " ++ string_of_int(count))}
            </button>
            
            <span
              data_testid="count-display"
              data_value={string_of_int(count)}
              data_is_positive={string_of_bool(count > 0)}
            >
              {React.int(count)}
            </span>
          </div>;
        };
      };
      
      let container = ReactTestingLibrary.render(<HooksIntegrationComponent initialCount=0 />);
      
      let component = getByTestId("hooks-integration", container);
      let statusDisplay = getByTestId("status-display", container);
      let counterData = getByTestId("counter-data", container);
      let incrementBtn = getByTestId("increment-btn", container);
      let countDisplay = getByTestId("count-display", container);
      
      // Test initial state
      expect(component->getAttribute("data-status"))->toEqual(Some("idle"));
      expect(incrementBtn->getAttribute("data-current-count"))->toEqual(Some("0"));
      expect(countDisplay->getAttribute("data-is-positive"))->toEqual(Some("false"));
      
      // Test static attributes
      expect(component->getAttribute("data-component"))->toEqual(Some("counter"));
      expect(statusDisplay->getAttribute("data-role"))->toEqual(Some("status-display"));
      expect(counterData->getAttribute("data-content"))->toEqual(Some("counter-data"));
      expect(incrementBtn->getAttribute("data-action"))->toEqual(Some("increment"));
    });
  });

  describe("Conditional rendering and dynamic UI", () => {
    test("should handle conditional data attributes based on component state", () => {
      module ConditionalComponent = {
        [@react.component]
        let make = () => {
          let (mode, setMode) = React.useState(() => "view");
          let (hasError, setHasError) = React.useState(() => false);
          let (isLoading, setIsLoading) = React.useState(() => false);
          
          <div data_testid="conditional-component" data_mode={mode} data_has_error={string_of_bool(hasError)}>
            {switch (mode) {
             | "view" =>
               <div data_testid="view-mode" data_state="readonly">
                 <span data_content="view-text" data_testid="view-content">
                   {React.string("Viewing content")}
                 </span>
                 <button
                   data_testid="edit-btn"
                   data_action="switch-to-edit"
                   onClick={_ => setMode(_ => "edit")}
                 >
                   {React.string("Edit")}
                 </button>
               </div>
             | "edit" =>
               <div data_testid="edit-mode" data_state="editable">
                 <input
                   data_testid="edit-input"
                   data_field="content"
                   data_validation={hasError ? "error" : "valid"}
                   placeholder="Edit content"
                 />
                 <div data_role="actions" data_testid="edit-actions">
                   <button
                     data_testid="save-btn"
                     data_action="save"
                     data_loading={string_of_bool(isLoading)}
                     onClick={_ => {
                       setIsLoading(_ => true);
                       setHasError(_ => false);
                       setMode(_ => "view");
                     }}
                   >
                     {React.string(isLoading ? "Saving..." : "Save")}
                   </button>
                   <button
                     data_testid="cancel-btn"
                     data_action="cancel"
                     onClick={_ => setMode(_ => "view")}
                   >
                     {React.string("Cancel")}
                   </button>
                 </div>
               </div>
             | _ =>
               <div data_testid="unknown-mode" data_state="error">
                 {React.string("Unknown mode")}
               </div>
             }}
            
            {hasError
               ? <div data_testid="error-message" data_severity="high" data_type="validation">
                   {React.string("Validation error occurred")}
                 </div>
               : React.null}
          </div>;
        };
      };
      
      let container = ReactTestingLibrary.render(<ConditionalComponent />);
      
      // Test initial view mode
      let component = getByTestId("conditional-component", container);
      let viewMode = getByTestId("view-mode", container);
      let viewContent = getByTestId("view-content", container);
      let editBtn = getByTestId("edit-btn", container);
      
      expect(component->getAttribute("data-mode"))->toEqual(Some("view"));
      expect(component->getAttribute("data-has-error"))->toEqual(Some("false"));
      expect(viewMode->getAttribute("data-state"))->toEqual(Some("readonly"));
      expect(viewContent->getAttribute("data-content"))->toEqual(Some("view-text"));
      expect(editBtn->getAttribute("data-action"))->toEqual(Some("switch-to-edit"));
    });
  });

  describe("List rendering with data attributes", () => {
    test("should handle dynamic list rendering with data attributes", () => {
      module ListComponent = {
        [@react.component]
        let make = (~items=[|"apple", "banana", "cherry", "date"|]) => {
          let (selectedIndex, setSelectedIndex) = React.useState(() => (-1));
          let (sortOrder, setSortOrder) = React.useState(() => "asc");
          
          let sortedItems = 
            sortOrder === "asc" 
              ? Belt.Array.copy(items) |> Js.Array.sortInPlace
              : Belt.Array.copy(items) |> Js.Array.sortInPlace |> Js.Array.reverseInPlace;
          
          <div data_testid="list-component" data_count={string_of_int(Array.length(items))} data_sort={sortOrder}>
            <div data_role="controls" data_testid="list-controls">
              <button
                data_testid="sort-btn"
                data_action="toggle-sort"
                data_current_sort={sortOrder}
                onClick={_ => setSortOrder(prev => prev === "asc" ? "desc" : "asc")}
              >
                {React.string("Sort " ++ (sortOrder === "asc" ? "Desc" : "Asc"))}
              </button>
            </div>
            
            <ul data_role="list" data_testid="item-list">
              {React.array(
                 Array.mapi((index, item) => {
                   <li
                     key={item ++ string_of_int(index)}
                     data_testid={"item-" ++ string_of_int(index)}
                     data_value={item}
                     data_index={string_of_int(index)}
                     data_selected={string_of_bool(index === selectedIndex)}
                     data_is_first={string_of_bool(index === 0)}
                     data_is_last={string_of_bool(index === Array.length(sortedItems) - 1)}
                     className={index === selectedIndex ? "selected" : ""}
                     onClick={_ => setSelectedIndex(_ => index)}
                   >
                     <span data_role="item-text" data_testid={"item-text-" ++ string_of_int(index)}>
                       {React.string(item)}
                     </span>
                     {index === selectedIndex
                        ? <span data_indicator="selected" data_testid="selected-indicator">
                            {React.string(" ✓")}
                          </span>
                        : React.null}
                   </li>
                 }, sortedItems)
               )}
            </ul>
            
            <div data_role="summary" data_testid="list-summary">
              <span data_content="total-count" data_testid="total-count">
                {React.string("Total: " ++ string_of_int(Array.length(items)))}
              </span>
              {selectedIndex >= 0 && selectedIndex < Array.length(sortedItems)
                 ? <span data_content="selected-item" data_testid="selected-summary">
                     {React.string(" | Selected: " ++ sortedItems[selectedIndex])}
                   </span>
                 : React.null}
            </div>
          </div>;
        };
      };
      
      let container = ReactTestingLibrary.render(<ListComponent />);
      
      let listComponent = getByTestId("list-component", container);
      let listControls = getByTestId("list-controls", container);
      let itemList = getByTestId("item-list", container);
      let item0 = getByTestId("item-0", container);
      let item1 = getByTestId("item-1", container);
      let sortBtn = getByTestId("sort-btn", container);
      
      expect(listComponent->getAttribute("data-count"))->toEqual(Some("4"));
      expect(listComponent->getAttribute("data-sort"))->toEqual(Some("asc"));
      expect(listControls->getAttribute("data-role"))->toEqual(Some("controls"));
      expect(itemList->getAttribute("data-role"))->toEqual(Some("list"));
      expect(item0->getAttribute("data-is-first"))->toEqual(Some("true"));
      expect(item0->getAttribute("data-selected"))->toEqual(Some("false"));
      expect(sortBtn->getAttribute("data-current-sort"))->toEqual(Some("asc"));
      
      // Items should be sorted alphabetically (apple, banana, cherry, date)
      expect(item0->getAttribute("data-value"))->toEqual(Some("apple"));
      expect(item1->getAttribute("data-value"))->toEqual(Some("banana"));
    });
  });

  describe("Component composition with data attributes", () => {
    test("should handle nested component composition with data attribute inheritance", () => {
      module ChildComponent = {
        [@react.component]
        let make = (~title, ~content, ~testId, ~priority="normal") => {
          <article data_testid={testId} data_component="child" data_title={title} data_priority={priority}>
            <header data_element="child-header" data_testid={testId ++ "-header"}>
              <h3 data_element="child-title" data_testid={testId ++ "-title"}>
                {React.string(title)}
              </h3>
            </header>
            <div data_element="child-content" data_testid={testId ++ "-content"} data_length={string_of_int(String.length(content))}>
              <p>{React.string(content)}</p>
            </div>
          </article>;
        };
      };
      
      module ParentComponent = {
        [@react.component]
        let make = (~theme="light") => {
          let (activeChild, setActiveChild) = React.useState(() => "child1");
          let (childrenCount, _setChildrenCount) = React.useState(() => 2);
          
          <main data_testid="parent-component" data_component="parent" data_theme={theme} data_active_child={activeChild}>
            <header data_role="parent-header" data_testid="parent-header">
              <h1 data_element="parent-title" data_testid="parent-title">
                {React.string("Parent Component")}
              </h1>
              <nav data_role="child-navigation" data_testid="child-nav" data_children_count={string_of_int(childrenCount)}>
                <button
                  data_testid="nav-child1"
                  data_target="child1"
                  data_active={string_of_bool(activeChild === "child1")}
                  onClick={_ => setActiveChild(_ => "child1")}
                >
                  {React.string("Child 1")}
                </button>
                <button
                  data_testid="nav-child2"
                  data_target="child2"
                  data_active={string_of_bool(activeChild === "child2")}
                  onClick={_ => setActiveChild(_ => "child2")}
                >
                  {React.string("Child 2")}
                </button>
              </nav>
            </header>
            
            <section data_role="content-area" data_testid="content-area" data_layout="grid">
              <ChildComponent
                testId="child1"
                title="First Child"
                content="Content for the first child component with more details"
                priority="high"
              />
              <ChildComponent
                testId="child2"
                title="Second Child"
                content="Content for the second child component"
                priority="normal"
              />
            </section>
            
            <aside data_role="sidebar" data_testid="sidebar" data_visible={string_of_bool(activeChild !== "")}>
              <div data_content="active-info" data_testid="active-info">
                {React.string("Active: " ++ activeChild)}
              </div>
            </aside>
            
            <footer data_role="parent-footer" data_testid="parent-footer" data_info="composition-demo">
              <span data_content="footer-text" data_copyright="2024">
                {React.string("Component composition example")}
              </span>
            </footer>
          </main>;
        };
      };
      
      let container = ReactTestingLibrary.render(<ParentComponent theme="dark" />);
      
      // Test parent component
      let parentComponent = getByTestId("parent-component", container);
      expect(parentComponent->getAttribute("data-component"))->toEqual(Some("parent"));
      expect(parentComponent->getAttribute("data-theme"))->toEqual(Some("dark"));
      expect(parentComponent->getAttribute("data-active-child"))->toEqual(Some("child1"));
      
      // Test navigation
      let childNav = getByTestId("child-nav", container);
      let navChild1 = getByTestId("nav-child1", container);
      let navChild2 = getByTestId("nav-child2", container);
      expect(childNav->getAttribute("data-children-count"))->toEqual(Some("2"));
      expect(navChild1->getAttribute("data-active"))->toEqual(Some("true"));
      expect(navChild2->getAttribute("data-active"))->toEqual(Some("false"));
      
      // Test child components
      let child1 = getByTestId("child1", container);
      let child2 = getByTestId("child2", container);
      let child1Content = getByTestId("child1-content", container);
      
      expect(child1->getAttribute("data-component"))->toEqual(Some("child"));
      expect(child1->getAttribute("data-title"))->toEqual(Some("First Child"));
      expect(child1->getAttribute("data-priority"))->toEqual(Some("high"));
      expect(child2->getAttribute("data-priority"))->toEqual(Some("normal"));
      expect(child1Content->getAttribute("data-length"))->toEqual(Some("55"));
      
      // Test sidebar and footer
      let sidebar = getByTestId("sidebar", container);
      let footer = getByTestId("parent-footer", container);
      expect(sidebar->getAttribute("data-visible"))->toEqual(Some("true"));
      expect(footer->getAttribute("data-info"))->toEqual(Some("composition-demo"));
    });
  });

  describe("Event handlers and interactive data attributes", () => {
    test("should handle data attributes with event handlers and form interactions", () => {
      module InteractiveForm = {
        type formData = {
          name: string,
          email: string,
          category: string,
        };
        
        [@react.component]
        let make = () => {
          let (formData, setFormData) = React.useState(() => {name: "", email: "", category: "general"});
          let (isSubmitted, setIsSubmitted) = React.useState(() => false);
          let (errors, setErrors) = React.useState(() => [||]);
          
          let updateField = (field, value) => {
            setFormData(prev => {
              switch (field) {
              | "name" => {...prev, name: value}
              | "email" => {...prev, email: value}
              | "category" => {...prev, category: value}
              | _ => prev
              }
            });
          };
          
          let validateAndSubmit = () => {
            let newErrors = ref([||]);
            if (String.length(formData.name) === 0) {
              newErrors := Array.append(newErrors^, [|"Name is required"|]);
            };
            if (String.length(formData.email) === 0) {
              newErrors := Array.append(newErrors^, [|"Email is required"|]);
            };
            
            setErrors(_ => newErrors^);
            if (Array.length(newErrors^) === 0) {
              setIsSubmitted(_ => true);
            };
          };
          
          <form data_testid="interactive-form" data_component="contact-form" data_submitted={string_of_bool(isSubmitted)}>
            <div data_role="form-section" data_testid="name-section">
              <label data_element="form-label" data_for="name-input">
                {React.string("Name:")}
              </label>
              <input
                data_testid="name-input"
                data_field="name"
                data_required="true"
                data_validation={Array.length(errors) > 0 && formData.name === "" ? "error" : "valid"}
                value={formData.name}
                onChange={event => updateField("name", event->React.Event.Form.target##value)}
                placeholder="Your name"
              />
            </div>
            
            <div data_role="form-section" data_testid="email-section">
              <label data_element="form-label" data_for="email-input">
                {React.string("Email:")}
              </label>
              <input
                data_testid="email-input"
                data_field="email"
                data_required="true"
                data_validation={Array.length(errors) > 0 && formData.email === "" ? "error" : "valid"}
                value={formData.email}
                onChange={event => updateField("email", event->React.Event.Form.target##value)}
                placeholder="your.email@example.com"
                type_="email"
              />
            </div>
            
            <div data_role="form-section" data_testid="category-section">
              <label data_element="form-label" data_for="category-select">
                {React.string("Category:")}
              </label>
              <select
                data_testid="category-select"
                data_field="category"
                data_options="general,support,sales"
                value={formData.category}
                onChange={event => updateField("category", event->React.Event.Form.target##value)}
              >
                <option value="general">{React.string("General")}</option>
                <option value="support">{React.string("Support")}</option>
                <option value="sales">{React.string("Sales")}</option>
              </select>
            </div>
            
            {Array.length(errors) > 0
               ? <div data_testid="error-list" data_role="validation-errors" data_count={string_of_int(Array.length(errors))}>
                   {React.array(
                      Array.mapi((index, error) => 
                        <div key={string_of_int(index)} data_testid={"error-" ++ string_of_int(index)} data_severity="error">
                          {React.string(error)}
                        </div>
                      , errors)
                   )}
                 </div>
               : React.null}
            
            <div data_role="form-actions" data_testid="form-actions">
              <button
                data_testid="submit-btn"
                data_action="form-submit"
                data_state={isSubmitted ? "submitted" : "pending"}
                data_enabled={string_of_bool(!isSubmitted)}
                onClick={_ => isSubmitted ? () : validateAndSubmit()}
                type_="button"
              >
                {React.string(isSubmitted ? "Submitted!" : "Submit")}
              </button>
              
              <button
                data_testid="reset-btn"
                data_action="form-reset"
                onClick={_ => {
                  setFormData(_ => {name: "", email: "", category: "general"});
                  setIsSubmitted(_ => false);
                  setErrors(_ => [||]);
                }}
                type_="button"
              >
                {React.string("Reset")}
              </button>
            </div>
            
            {isSubmitted
               ? <div data_testid="success-message" data_role="feedback" data_type="success">
                   {React.string("Form submitted successfully!")}
                 </div>
               : React.null}
          </form>;
        };
      };
      
      let container = ReactTestingLibrary.render(<InteractiveForm />);
      
      // Test form structure
      let form = getByTestId("interactive-form", container);
      let nameSection = getByTestId("name-section", container);
      let _emailSection = getByTestId("email-section", container);
      let _categorySection = getByTestId("category-section", container);
      let nameInput = getByTestId("name-input", container);
      let emailInput = getByTestId("email-input", container);
      let categorySelect = getByTestId("category-select", container);
      let submitBtn = getByTestId("submit-btn", container);
      let resetBtn = getByTestId("reset-btn", container);
      
      expect(form->getAttribute("data-component"))->toEqual(Some("contact-form"));
      expect(form->getAttribute("data-submitted"))->toEqual(Some("false"));
      expect(nameSection->getAttribute("data-role"))->toEqual(Some("form-section"));
      expect(nameInput->getAttribute("data-field"))->toEqual(Some("name"));
      expect(nameInput->getAttribute("data-required"))->toEqual(Some("true"));
      expect(emailInput->getAttribute("data-field"))->toEqual(Some("email"));
      expect(categorySelect->getAttribute("data-options"))->toEqual(Some("general,support,sales"));
      expect(submitBtn->getAttribute("data-action"))->toEqual(Some("form-submit"));
      expect(submitBtn->getAttribute("data-state"))->toEqual(Some("pending"));
      expect(resetBtn->getAttribute("data-action"))->toEqual(Some("form-reset"));
    });
  });
});