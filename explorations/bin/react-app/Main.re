[@refmt.staticExperiment];
open ReactLib;

module TapIneraction = TapInteraction;

print_string("HELLO");

print_newline();

let startSeconds = Sys.time();

StaticReactPrint.suppress.contents = false;

let run = () => {
  for (i in 0 to 0) {
    let stateless = <Stateless txt="stateless" />;
    /*
     * You would get generalization errors, if you didn't close this in a JSX element.
     */
    /* let button = React.One(Button.render(~txt="hello", ~size=0, React.Empty)); */
    /*
     * Maintains count of number of times the size changes. Another good example of
     * getDerivedStateFromProps.
     */
    /* Uncomment to check quality of type errors */
    /* let two = React.Element(ReactDOM.div(~className="helloClass", React.Empty)); */
    /* let retTwo = */
    /*   Random.int(0) > 0 ? */
    /*     React.Element(ChildContainer.render(~txt="hello",  two)) : */
    /*     React.Element2( */
    /*       Button.render(~txt="hello", ~size=0, Empty), */
    /*       Dom.div(~className="helloClass", children), */
    /*     ); */
    StaticReactPrint.printSection(
      "\n\n-------------------\nChild Container \n-------------------",
    );
    let containerRoot = StaticReactRoot.create();
    for (j in 0 to 10) {
      StaticReactRoot.render(
        containerRoot,
        <ChildContainer txt="Foo">
          <Stateless txt="stateless" />
        </ChildContainer>,
      );
    };
    StaticReactPrint.printSection(
      "\n\n-------------------\nGets Derived State From Props\n-------------------",
    );
    let counterRoot = StaticReactRoot.create();
    StaticReactRoot.render(
      counterRoot,
      <GetsDerivedStateFromProps txt="Foo" size=0>
        stateless
      </GetsDerivedStateFromProps>,
    );
    StaticReactPrint.printRoot(~title="Init:", counterRoot);
    StaticReactRoot.render(
      counterRoot,
      <GetsDerivedStateFromProps txt="Foo" size=0>
        stateless
      </GetsDerivedStateFromProps>,
    );
    StaticReactPrint.printRoot(
      ~title="Update Without Changing Props:",
      counterRoot,
    );
    StaticReactRoot.render(
      counterRoot,
      <GetsDerivedStateFromProps txt="Foo" size=8>
        stateless
      </GetsDerivedStateFromProps>,
    );
    StaticReactPrint.printRoot(
      ~title="Update With Changing Props:",
      counterRoot,
    );
    StaticReactPrint.printSection(
      "\n\n------------------------------\nApp With Request Animation Frame \n------------------------------",
    );
    let animRoot = StaticReactRoot.create();
    StaticReactRoot.render(
      animRoot,
      <RequestAnimationFrameComponent txt="" />,
    );
    StaticReactPrint.printRoot(~title="Init:", animRoot);
    StaticReactRequestAnimationFrame.tick();
    StaticReactPrint.printRoot(~title="Update After raf tick:", animRoot);
    StaticReactRequestAnimationFrame.tick();
    StaticReactPrint.printRoot(~title="Update After raf tick:", animRoot);
    /* Clear this otherwise they'll show up in next loop iteration */
    StaticReactRequestAnimationFrame.clearAll();
    StaticReactPrint.printSection(
      "\n\n------------------------------\nApp With Polymoprhic State \n------------------------------",
    );
    let polyRoot = StaticReactRoot.create();
    StaticReactRoot.render(
      polyRoot,
      <PolymorphicState anyProp="hello" size="zero" />,
    );
    StaticReactPrint.printRoot(~title="Init:", polyRoot);
    let anotherPolyRoot = StaticReactRoot.create();
    StaticReactRoot.render(
      anotherPolyRoot,
      <PolymorphicState anyProp=0 size="zero" />,
    );
    StaticReactPrint.printRoot(~title="Another Type Init:", anotherPolyRoot);

    StaticReactPrint.printSection(
      "\n\n------------------------------\nApp With Controlled Input\n------------------------------",
    );
    let appRoot = StaticReactRoot.create();
    StaticReactRoot.render(
      appRoot,
      <InputController shouldControlInput=false> stateless </InputController>,
    );
    StaticReactPrint.printRoot(~title="Init:", appRoot);
    StaticReactRoot.render(
      appRoot,
      <InputController shouldControlInput=true />,
    );
    StaticReactPrint.printRoot(~title="Update:", appRoot);

    StaticReactPrint.printSection(
      "\n\n------------------------------\nDisplay Text\n------------------------------",
    );
    let appRoot = StaticReactRoot.create();
    open StaticReactDOM;
    StaticReactRoot.render(
      appRoot,
      <div className="myClassName">
        <p> "And you can write freeform text here" </p>
      </div>,
    );
    StaticReactPrint.printRoot(~title="Freeform Text:", appRoot);
  };
};
run();
let endSeconds = Sys.time();

Printf.printf(
  "\nTotal ms (Title): %d\n",
  int_of_float((endSeconds -. startSeconds) *. 1000.0),
);
