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
