[@refmt.staticExperiment];
open StaticReact;

module TapIneraction = TapInteraction;

print_string("HELLO");

print_newline();

let startSeconds = Sys.time();

ReactPrint.suppress.contents = false;

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
    ReactPrint.printSection(
      "\n\n-------------------\nChild Container \n-------------------",
    );
    let containerRoot = ReactRoot.create();
    for (j in 0 to 10) {
      ReactRoot.render(
        containerRoot,
        <ChildContainer txt="Foo">
          <Stateless txt="stateless" />
        </ChildContainer>,
      );
    };
    ReactPrint.printSection(
      "\n\n-------------------\nGets Derived State From Props\n-------------------",
    );
    let counterRoot = ReactRoot.create();
    ReactRoot.render(
      counterRoot,
      <GetsDerivedStateFromProps txt="Foo" size=0>
        stateless
      </GetsDerivedStateFromProps>,
    );
    ReactPrint.printRoot(~title="Init:", counterRoot);
    ReactRoot.render(
      counterRoot,
      <GetsDerivedStateFromProps txt="Foo" size=0>
        stateless
      </GetsDerivedStateFromProps>,
    );
    ReactPrint.printRoot(
      ~title="Update Without Changing Props:",
      counterRoot,
    );
    ReactRoot.render(
      counterRoot,
      <GetsDerivedStateFromProps txt="Foo" size=8>
        stateless
      </GetsDerivedStateFromProps>,
    );
    ReactPrint.printRoot(~title="Update With Changing Props:", counterRoot);
    ReactPrint.printSection(
      "\n\n------------------------------\nApp With Request Animation Frame \n------------------------------",
    );
    let animRoot = ReactRoot.create();
    ReactRoot.render(animRoot, <RequestAnimationFrameComponent txt="" />);
    ReactPrint.printRoot(~title="Init:", animRoot);
    ReactRequestAnimationFrame.tick();
    ReactPrint.printRoot(~title="Update After raf tick:", animRoot);
    ReactRequestAnimationFrame.tick();
    ReactPrint.printRoot(~title="Update After raf tick:", animRoot);
    /* Clear this otherwise they'll show up in next loop iteration */
    ReactRequestAnimationFrame.clearAll();
    ReactPrint.printSection(
      "\n\n------------------------------\nApp With Polymoprhic State \n------------------------------",
    );
    let polyRoot = ReactRoot.create();
    ReactRoot.render(
      polyRoot,
      <PolymorphicState anyProp="hello" size="zero" />,
    );
    ReactPrint.printRoot(~title="Init:", polyRoot);
    let anotherPolyRoot = ReactRoot.create();
    ReactRoot.render(
      anotherPolyRoot,
      <PolymorphicState anyProp=0 size="zero" />,
    );
    ReactPrint.printRoot(~title="Another Type Init:", anotherPolyRoot);

    ReactPrint.printSection(
      "\n\n------------------------------\nApp With Controlled Input\n------------------------------",
    );
    let appRoot = ReactRoot.create();
    ReactRoot.render(
      appRoot,
      <InputController shouldControlInput=false> stateless </InputController>,
    );
    ReactPrint.printRoot(~title="Init:", appRoot);
    ReactRoot.render(appRoot, <InputController shouldControlInput=true />);
    ReactPrint.printRoot(~title="Update:", appRoot);

    ReactPrint.printSection(
      "\n\n------------------------------\nDisplay Text\n------------------------------",
    );
    let appRoot = ReactRoot.create();
    open ReactDOM;
    ReactRoot.render(
      appRoot,
      <div className="myClassName">
        <p> "And you can write freeform text here" </p>
      </div>,
    );
    ReactPrint.printRoot(~title="Freeform Text:", appRoot);
  };
};
run();
let endSeconds = Sys.time();

Printf.printf(
  "\nTotal ms (Title): %d\n",
  int_of_float((endSeconds -. startSeconds) *. 1000.0),
);
