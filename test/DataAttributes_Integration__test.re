open Jest;
open Expect;

external getAttribute: (Dom.element, string) => option(string) = "getAttribute";

let getByTestId = (testId, container) => {
  ReactTestingLibrary.getByTestId(~matcher=`Str(testId), container);
};

describe("Data Attributes - React Component Integration", () => {
  
  describe("React Hooks Integration with Data Attributes", () => {
    
    test("should integrate data attributes with useState hook", () => {
      module CounterWithDataAttrs = {
        [@react.component]
        let make = (~testId="counter") => {
          let (count, setCount) = React.useState(() => 0);
          
          <div data_testid={testId} data_component="counter" data_count={string_of_int(count)}>
            <button 
              data_action="increment" 
              data_testid="increment-btn"
              onClick={_ => setCount(prev => prev + 1)}
            >
              {React.string("Increment")}
            </button>
            <span 
              data_role="display" 
              data_testid="count-display"
              className="count-value"
            >
              {React.int(count)}
            </span>
          </div>;
        };
      };
      
      let container = ReactTestingLibrary.render(<CounterWithDataAttrs />);
      
      let counterDiv = getByTestId("counter", container);
      let incrementBtn = getByTestId("increment-btn", container);
      let countDisplay = getByTestId("count-display", container);
      
      expect(counterDiv->getAttribute("data-component"))->toEqual(Some("counter"));
      expect(incrementBtn->getAttribute("data-action"))->toEqual(Some("increment"));
      expect(countDisplay->getAttribute("data-role"))->toEqual(Some("display"));
    });
    
    test("should integrate data attributes with useEffect hook", () => {
      module EffectComponentWithDataAttrs = {
        [@react.component]
        let make = () => {
          let (status, setStatus) = React.useState(() => "loading");
          let (data, setData) = React.useState(() => "");
          
          React.useEffect0(() => {
            setStatus(_ => "loaded");
            setData(_ => "Hello from effect!");
            None;
          });
          
          <div data_testid="effect-component" data_status={status}>
            <div data_role="status" data_testid="status-display">
              {React.string(status)}
            </div>
            <div data_content="async-data" data_testid="data-display">
              {React.string(data)}
            </div>
          </div>;
        };
      };
      
      let container = ReactTestingLibrary.render(<EffectComponentWithDataAttrs />);
      
      let component = getByTestId("effect-component", container);
      let statusDisplay = getByTestId("status-display", container);
      let dataDisplay = getByTestId("data-display", container);
      
      expect(component->getAttribute("data-status"))->toEqual(Some("loaded"));
      expect(statusDisplay->getAttribute("data-role"))->toEqual(Some("status"));
      expect(dataDisplay->getAttribute("data-content"))->toEqual(Some("async-data"));
    });
  });
  
  describe("Data Attribute Deduplication in Components", () => {
    
    test("should handle same data attributes used multiple times in one component", () => {
      module ComponentWithDuplicateDataAttrs = {
        [@react.component]
        let make = (~category="default") => {
          <div data_testid="duplicate-test" data_category={category}>
            <div data_testid="item-1" data_category={category} data_index="1">
              {React.string("Item 1")}
            </div>
            <div data_testid="item-2" data_category={category} data_index="2">
              {React.string("Item 2")}
            </div>
            <div data_testid="item-3" data_category={category} data_index="3">
              {React.string("Item 3")}
            </div>
          </div>;
        };
      };
      
      let container = ReactTestingLibrary.render(<ComponentWithDuplicateDataAttrs category="test" />);
      
      let mainDiv = getByTestId("duplicate-test", container);
      let item1 = getByTestId("item-1", container);
      let item2 = getByTestId("item-2", container);
      let item3 = getByTestId("item-3", container);
      
      expect(mainDiv->getAttribute("data-category"))->toEqual(Some("test"));
      expect(item1->getAttribute("data-category"))->toEqual(Some("test"));
      expect(item2->getAttribute("data-category"))->toEqual(Some("test"));
      expect(item3->getAttribute("data-category"))->toEqual(Some("test"));
    });
  });
  
  describe("Multiple Element Types with Data Attributes", () => {
    
    test("should handle different element types within React components", () => {
      module MultiElementComponent = {
        [@react.component]
        let make = (~formId="test-form") => {
          let (inputValue, setInputValue) = React.useState(() => "");
          let (isSubmitted, setIsSubmitted) = React.useState(() => false);
          
          <form data_testid={formId} data_component="multi-element-form">
            <div data_role="header" data_testid="form-header">
              <h2 data_element="heading" data_testid="form-title">
                {React.string("Multi-Element Form")}
              </h2>
            </div>
            
            <div data_role="input-section" data_testid="input-section">
              <label data_element="label" data_for="test-input">
                {React.string("Test Input:")}
              </label>
              <input
                data_testid="test-input"
                data_field="user-input"
                data_validation="required"
                value={inputValue}
                onChange={event => setInputValue(_ => event->React.Event.Form.target##value)}
                placeholder="Enter text here"
              />
            </div>
            
            <div data_role="actions" data_testid="form-actions">
              <button
                data_testid="submit-btn"
                data_action="submit"
                data_state={isSubmitted ? "submitted" : "pending"}
                onClick={_ => setIsSubmitted(_ => true)}
                type_="button"
              >
                {React.string("Submit")}
              </button>
              <span
                data_role="status"
                data_testid="submit-status"
                data_visible={string_of_bool(isSubmitted)}
              >
                {isSubmitted ? React.string("Submitted!") : React.null}
              </span>
            </div>
          </form>;
        };
      };
      
      let container = ReactTestingLibrary.render(<MultiElementComponent />);
      
      let form = getByTestId("test-form", container);
      let header = getByTestId("form-header", container);
      let title = getByTestId("form-title", container);
      let inputSection = getByTestId("input-section", container);
      let input = getByTestId("test-input", container);
      let actions = getByTestId("form-actions", container);
      let submitBtn = getByTestId("submit-btn", container);
      let status = getByTestId("submit-status", container);
      
      expect(form->getAttribute("data-component"))->toEqual(Some("multi-element-form"));
      expect(header->getAttribute("data-role"))->toEqual(Some("header"));
      expect(title->getAttribute("data-element"))->toEqual(Some("heading"));
      expect(input->getAttribute("data-field"))->toEqual(Some("user-input"));
      expect(submitBtn->getAttribute("data-action"))->toEqual(Some("submit"));
      expect(status->getAttribute("data-role"))->toEqual(Some("status"));
    });
  });
  
  describe("Data Attributes Mixed with Other Props", () => {
    
    test("should handle data attributes alongside className, style, and event handlers", () => {
      module StyledComponentWithDataAttrs = {
        [@react.component]
        let make = (~theme="light") => {
          let (isActive, setIsActive) = React.useState(() => false);
          
          <div 
            data_testid="styled-component"
            data_theme={theme}
            data_active={string_of_bool(isActive)}
            className={"styled-container " ++ theme ++ "-theme"}
            style={ReactDOM.Style.make(
              ~padding="16px",
              ~border="1px solid #ccc", 
              ~borderRadius="4px",
              ()
            )}
          >
            <button
              data_testid="toggle-btn"
              data_action="toggle"
              data_state={isActive ? "active" : "inactive"}
              className={"toggle-button " ++ (isActive ? "active" : "inactive")}
              style={ReactDOM.Style.make(
                ~backgroundColor={isActive ? "#007bff" : "#6c757d"},
                ~color="white",
                ~padding="8px 16px",
                ~border="none",
                ~borderRadius="4px",
                ()
              )}
              onClick={_ => setIsActive(prev => !prev)}
            >
              {React.string(isActive ? "Active" : "Inactive")}
            </button>
            
            <span
              data_testid="status-text"
              data_content="status-message"
              data_theme={theme}
              className="status-message"
              style={ReactDOM.Style.make(
                ~marginLeft="8px",
                ~fontWeight={isActive ? "bold" : "normal"},
                ()
              )}
            >
              {React.string("Status: " ++ (isActive ? "ON" : "OFF"))}
            </span>
          </div>;
        };
      };
      
      let container = ReactTestingLibrary.render(<StyledComponentWithDataAttrs theme="dark" />);
      
      let component = getByTestId("styled-component", container);
      let toggleBtn = getByTestId("toggle-btn", container);
      let statusText = getByTestId("status-text", container);
      
      expect(component->getAttribute("data-theme"))->toEqual(Some("dark"));
      expect(toggleBtn->getAttribute("data-action"))->toEqual(Some("toggle"));
      expect(statusText->getAttribute("data-content"))->toEqual(Some("status-message"));
    });
  });
  
  describe("Conditional Rendering with Data Attributes", () => {
    
    test("should handle conditional data attributes based on component state", () => {
      module ConditionalComponent = {
        [@react.component]
        let make = () => {
          let (mode, setMode) = React.useState(() => "view");
          let (hasError, setHasError) = React.useState(() => false);
          
          <div data_testid="conditional-component" data_mode={mode}>
            {switch (mode) {
             | "view" =>
               <div data_testid="view-mode" data_state="readonly">
                 <span data_content="view-text">
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
                     onClick={_ => {
                       setHasError(_ => false);
                       setMode(_ => "view");
                     }}
                   >
                     {React.string("Save")}
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
      
      let component = getByTestId("conditional-component", container);
      let viewMode = getByTestId("view-mode", container);
      let editBtn = getByTestId("edit-btn", container);
      
      expect(component->getAttribute("data-mode"))->toEqual(Some("view"));
      expect(viewMode->getAttribute("data-state"))->toEqual(Some("readonly"));
      expect(editBtn->getAttribute("data-action"))->toEqual(Some("switch-to-edit"));
    });
  });
  
  describe("List Rendering with Data Attributes", () => {
    
    test("should handle components that map over data to create elements with data attributes", () => {
      module ListComponent = {
        [@react.component]
        let make = (~items=[|"apple", "banana", "cherry"|]) => {
          let (selectedIndex, setSelectedIndex) = React.useState(() => (-1));
          
          <div data_testid="list-component" data_count={string_of_int(Array.length(items))}>
            <ul data_role="list" data_testid="item-list">
              {React.array(
                 Array.mapi((index, item) => {
                   <li
                     key={string_of_int(index)}
                     data_testid={"item-" ++ string_of_int(index)}
                     data_value={item}
                     data_index={string_of_int(index)}
                     data_selected={string_of_bool(index === selectedIndex)}
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
                 }, items)
               )}
            </ul>
            
            <div data_role="summary" data_testid="list-summary">
              <span data_content="total-count">
                {React.string("Total items: " ++ string_of_int(Array.length(items)))}
              </span>
              {selectedIndex >= 0
                 ? <span data_content="selected-item" data_testid="selected-summary">
                     {React.string(" | Selected: " ++ items[selectedIndex])}
                   </span>
                 : React.null}
            </div>
          </div>;
        };
      };
      
      let container = ReactTestingLibrary.render(<ListComponent />);
      
      let listComponent = getByTestId("list-component", container);
      let itemList = getByTestId("item-list", container);
      let item0 = getByTestId("item-0", container);
      let item1 = getByTestId("item-1", container);
      let listSummary = getByTestId("list-summary", container);
      
      expect(listComponent->getAttribute("data-count"))->toEqual(Some("3"));
      expect(itemList->getAttribute("data-role"))->toEqual(Some("list"));
      expect(item0->getAttribute("data-value"))->toEqual(Some("apple"));
      expect(item1->getAttribute("data-value"))->toEqual(Some("banana"));
    });
  });
  
  describe("Nested Component Composition with Data Attributes", () => {
    
    test("should handle nested components where parent and child both use data attributes", () => {
      module ChildComponent = {
        [@react.component]
        let make = (~title, ~content, ~testId) => {
          <div data_testid={testId} data_component="child" data_title={title}>
            <h3 data_element="child-title" data_testid={testId ++ "-title"}>
              {React.string(title)}
            </h3>
            <p data_element="child-content" data_testid={testId ++ "-content"}>
              {React.string(content)}
            </p>
          </div>;
        };
      };
      
      module ParentComponent = {
        [@react.component]
        let make = () => {
          let (activeChild, setActiveChild) = React.useState(() => "child1");
          
          <div data_testid="parent-component" data_component="parent" data_active={activeChild}>
            <header data_role="parent-header" data_testid="parent-header">
              <h1 data_element="parent-title">
                {React.string("Parent Component")}
              </h1>
              <nav data_role="child-navigation" data_testid="child-nav">
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
            
            <main data_role="content-area" data_testid="content-area">
              <ChildComponent
                testId="child1"
                title="First Child"
                content="Content for the first child component"
              />
              <ChildComponent
                testId="child2"
                title="Second Child"
                content="Content for the second child component"
              />
            </main>
            
            <footer data_role="parent-footer" data_testid="parent-footer" data_info="nested-composition">
              <span data_content="footer-text">
                {React.string("Nested component composition example")}
              </span>
            </footer>
          </div>;
        };
      };
      
      let container = ReactTestingLibrary.render(<ParentComponent />);
      
      let parentComponent = getByTestId("parent-component", container);
      let parentHeader = getByTestId("parent-header", container);
      let childNav = getByTestId("child-nav", container);
      let child1 = getByTestId("child1", container);
      let child2 = getByTestId("child2", container);
      let child1Title = getByTestId("child1-title", container);
      let parentFooter = getByTestId("parent-footer", container);
      
      expect(parentComponent->getAttribute("data-component"))->toEqual(Some("parent"));
      expect(parentHeader->getAttribute("data-role"))->toEqual(Some("parent-header"));
      expect(childNav->getAttribute("data-role"))->toEqual(Some("child-navigation"));
      expect(child1->getAttribute("data-component"))->toEqual(Some("child"));
      expect(child1->getAttribute("data-title"))->toEqual(Some("First Child"));
      expect(child2->getAttribute("data-title"))->toEqual(Some("Second Child"));
      expect(parentFooter->getAttribute("data-info"))->toEqual(Some("nested-composition"));
    });
  });
  
  describe("Performance and Complex Integration Scenarios", () => {
    
    testAsync("should handle real-world complex component with data attributes", finish => {
      module ComplexDashboard = {
        [@react.component]
        let make = () => {
          let (users, setUsers) = React.useState(() => [|
            {"id": "1", "name": "Alice", "role": "admin", "active": true},
            {"id": "2", "name": "Bob", "role": "user", "active": false},
            {"id": "3", "name": "Charlie", "role": "moderator", "active": true}
          |]);
          let (filter, setFilter) = React.useState(() => "all");
          let (sortBy, setSortBy) = React.useState(() => "name");
          
          React.useEffect0(() => {
            finish();
            None;
          });
          
          let filteredUsers = users->Belt.Array.keep(user => {
            switch (filter) {
            | "active" => user##active
            | "inactive" => !user##active
            | _ => true
            };
          });
          
          <div data_testid="dashboard" data_component="user-dashboard" data_filter={filter} data_sort={sortBy}>
            <header data_role="dashboard-header" data_testid="dashboard-header">
              <h1 data_element="dashboard-title">
                {React.string("User Dashboard")}
              </h1>
              
              <div data_role="controls" data_testid="dashboard-controls">
                <select
                  data_testid="filter-select"
                  data_control="filter"
                  data_value={filter}
                  onChange={event => setFilter(_ => event->React.Event.Form.target##value)}
                >
                  <option data_option="all" value="all">{React.string("All Users")}</option>
                  <option data_option="active" value="active">{React.string("Active Users")}</option>
                  <option data_option="inactive" value="inactive">{React.string("Inactive Users")}</option>
                </select>
                
                <select
                  data_testid="sort-select"
                  data_control="sort"
                  data_value={sortBy}
                  onChange={event => setSortBy(_ => event->React.Event.Form.target##value)}
                >
                  <option data_option="name" value="name">{React.string("Sort by Name")}</option>
                  <option data_option="role" value="role">{React.string("Sort by Role")}</option>
                </select>
              </div>
            </header>
            
            <main data_role="user-list" data_testid="user-list" data_count={string_of_int(Array.length(filteredUsers))}>
              <table data_element="user-table" data_testid="user-table">
                <thead data_section="table-header">
                  <tr data_row="header">
                    <th data_column="name" data_sortable="true">
                      {React.string("Name")}
                    </th>
                    <th data_column="role" data_sortable="true">
                      {React.string("Role")}
                    </th>
                    <th data_column="status" data_sortable="false">
                      {React.string("Status")}
                    </th>
                    <th data_column="actions" data_sortable="false">
                      {React.string("Actions")}
                    </th>
                  </tr>
                </thead>
                <tbody data_section="table-body">
                  {React.array(
                     Array.mapi((index, user) => {
                       <tr
                         key={user##id}
                         data_testid={"user-row-" ++ user##id}
                         data_user_id={user##id}
                         data_index={string_of_int(index)}
                         data_active={string_of_bool(user##active)}
                       >
                         <td data_cell="name" data_testid={"user-name-" ++ user##id}>
                           {React.string(user##name)}
                         </td>
                         <td data_cell="role" data_testid={"user-role-" ++ user##id} data_role_value={user##role}>
                           <span data_badge={user##role} className={"role-badge role-" ++ user##role}>
                             {React.string(user##role)}
                           </span>
                         </td>
                         <td data_cell="status" data_testid={"user-status-" ++ user##id}>
                           <span
                             data_status={user##active ? "active" : "inactive"}
                             className={user##active ? "status-active" : "status-inactive"}
                           >
                             {React.string(user##active ? "Active" : "Inactive")}
                           </span>
                         </td>
                         <td data_cell="actions" data_testid={"user-actions-" ++ user##id}>
                           <button
                             data_testid={"edit-user-" ++ user##id}
                             data_action="edit"
                             data_user_id={user##id}
                             onClick={_ => Js.log("Edit user " ++ user##id)}
                           >
                             {React.string("Edit")}
                           </button>
                           <button
                             data_testid={"toggle-user-" ++ user##id}
                             data_action="toggle"
                             data_user_id={user##id}
                             data_current_status={string_of_bool(user##active)}
                             onClick={_ => {
                               let updatedUsers = users->Belt.Array.map(u =>
                                 u##id === user##id 
                                   ? {"id": u##id, "name": u##name, "role": u##role, "active": !u##active}
                                   : u
                               );
                               setUsers(_ => updatedUsers);
                             }}
                           >
                             {React.string(user##active ? "Deactivate" : "Activate")}
                           </button>
                         </td>
                       </tr>
                     }, filteredUsers)
                   )}
                </tbody>
              </table>
            </main>
            
            <footer data_role="dashboard-footer" data_testid="dashboard-footer">
              <div data_stats="user-counts" data_testid="user-stats">
                <span data_metric="total" data_testid="total-users">
                  {React.string("Total: " ++ string_of_int(Array.length(users)))}
                </span>
                <span data_metric="filtered" data_testid="filtered-users">
                  {React.string(" | Showing: " ++ string_of_int(Array.length(filteredUsers)))}
                </span>
                <span data_metric="active" data_testid="active-count">
                  {React.string(" | Active: " ++ string_of_int(
                       users->Belt.Array.keep(u => u##active)->Belt.Array.length
                     ))}
                </span>
              </div>
            </footer>
          </div>;
        };
      };
      
      let _container = ReactTestingLibrary.render(<ComplexDashboard />);
      ();
    });
  });
});