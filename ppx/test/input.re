let lower = <div />;
let lower_empty_attr = <div className="" />;
let lower_inline_styles =
  <div style={ReactDOM.Style.make(~backgroundColor="gainsboro", ())} />;
let lower_inner_html = <div dangerouslySetInnerHTML={"__html": text} />;
let lower_opt_attr = <div ?tabIndex />;

let lowerWithChildAndProps = foo =>
  <a tabIndex=1 href="https://example.com"> foo </a>;

let lower_child_static = <div> <span /> </div>;
let lower_child_ident = <div> lolaspa </div>;
let lower_child_single = <div> <div /> </div>;
let lower_children_multiple = (foo, bar) => <lower> foo bar </lower>;
let lower_child_with_upper_as_children = <div> <App /> </div>;

let lower_children_nested =
  <div className="flex-container">
    <div className="sidebar">
      <h2 className="title"> {"jsoo-react" |> s} </h2>
      <nav className="menu">
        <ul>
          {examples
           |> List.map(e =>
                <li key={e.path}>
                  <a
                    href={e.path}
                    onClick={event => {
                      ReactEvent.Mouse.preventDefault(event);
                      ReactRouter.push(e.path);
                    }}>
                    {e.title |> s}
                  </a>
                </li>
              )
           |> React.list}
        </ul>
      </nav>
    </div>
  </div>;

let fragment = foo => [@bla] <> foo </>;

let poly_children_fragment = (foo, bar) => <> foo bar </>;
let nested_fragment = (foo, bar, baz) => <> foo <> bar baz </> </>;

let nested_fragment_with_lower = foo => <> <div> foo </div> </>;

let upper = <Upper />;

let upper_prop = <Upper count />;

let upper_children_single = foo => <Upper> foo </Upper>;

let upper_children_multiple = (foo, bar) => <Upper> foo bar </Upper>;

let upper_children =
  <Page moreProps="hgalo"> <h1> {React.string("Yep")} </h1> </Page>;

let upper_nested_module = <Foo.Bar a=1 b="1" />;

let upper_child_expr = <Div> {React.int(1)} </Div>;
let upper_child_ident = <Div> lola </Div>;

let upper_all_kinds_of_props =
  <MyComponent
    booleanAttribute=true
    stringAttribute="string"
    intAttribute=1
    forcedOptional=?{Some("hello")}
    onClick={send(handleClick)}>
    <div> "hello" </div>
  </MyComponent>;

let upper_ref_with_children =
  <FancyButton ref=buttonRef> <div /> </FancyButton>;

let lower_ref_with_children =
  <button ref className="FancyButton"> children </button>;

let lower_with_many_props =
  <div translate="yes">
    <picture id="idpicture">
      <img src="picture/img.png" alt="test picture/img.png" id="idimg" />
      <source type_="image/webp" src="picture/img1.webp" />
      <source type_="image/jpeg" src="picture/img2.jpg" />
    </picture>
  </div>;

let some_random_html_element = <text dx="1 2" dy="3 4" />;

/* Components */
module React_component_with_props = {
  [@react.component]
  let make = (~lola) => {
    <div> {React.string(lola)} </div>;
  };
};

let react_component_with_props = <React_component_with_props lola="flores" />;

module Upper_case_with_fragment_as_root = {
  [@react.component]
  let make = (~name="") =>
    <>
      <div> {React.string("First " ++ name)} </div>
      <Hello one="1"> {React.string("2nd " ++ name)} </Hello>
    </>;
};

/* module Using_React_memo = {
     [@react.component]
     let make =
       React.memo((~a) =>
         <div> {Printf.sprintf("`a` is %s", a) |> React.string} </div>
       );
   }; */

/* module Using_memo_custom_compare_Props = {
     [@react.component]
     let make =
       React.memo(
         (~a) => <div> {Printf.sprintf("`a` is %d", a) |> React.string} </div>,
         (prevPros, nextProps) => false,
       );
   }; */

module Forward_Ref = {
  [@react.component]
  let make =
    React.forwardRef((~children, ~buttonRef) => {
      <button ref=buttonRef className="FancyButton"> children </button>
    });
};

module Onclick_handler_button = {
  [@react.component]
  let make = (~name, ~isDisabled=?) => {
    let onClick = event => Js.log(event);
    <button name onClick disabled=isDisabled />;
  };
};

module Children_as_string = {
  [@react.component]
  let make = (~name="joe") =>
    <div> {Printf.sprintf("`name` is %s", name) |> React.string} </div>;
};

/* It shoudn't remove this :/ */
let () = Dream.run();
let l = 33;

module Uppercase_with_SSR_components = {
  [@react.component]
  let make = (~children, ~moreProps) =>
    <html>
      <head>
        <title> {React.string("SSR React " ++ moreProps)} </title>
      </head>
      <body>
        <div id="root"> children </div>
        <script src="/static/client.js" />
      </body>
    </html>;
};

module Upper_with_aria = {
  [@react.component]
  let make = (~children) => <div ariaHidden="true"> children </div>;
};

let data_attributes_should_transform_to_kebabcase =
  <>
    <div dataAttribute="" dataattribute="" className="md:w-1/3" />
    <div className="md:w-2/3" />
  </>;

let render_onclickPropsAsString = <div _onclick="alert('hello')" />;

module External = {
  [@react.component] [@otherAttribute "bla"]
  external component: (~a: int, ~b: string) => React.element =
    {|require("my-react-library").MyReactComponent|};
};

module type X_int = {let x: int;};

module Func = (M: X_int) => {
  let x = M.x + 1;
  [@react.component]
  let make = (~a, ~b, _) => {
    print_endline("This function should be named `Test$Func`", M.x);
    <div />;
  };
};
