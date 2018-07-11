open ReactLib;

print_string("HELLO");

print_newline();

let startSeconds = Sys.time();

ReactPrint.suppress.contents = false;

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
  /* let retTwo = */
  /*   Random.int(0) > 0 ? */
  /*     React.One(ChildContainer.render(~txt="hello", ~size=0, two)) : */
  /*     React.Two( */
  /*       Button.render(~txt="hello", ~size=0, Empty), */
  /*       Dom.div(~className="helloClass", children), */
  /*     ); */
  ReactPrint.printSection(
    "\n\n-------------------\nChild Container \n-------------------",
  );
  let containerRoot = Root.create();
  for (j in 0 to 10) {
    Root.render(
      containerRoot,
      <ChildContainer txt="Foo">
        <Stateless txt="stateless" />
      </ChildContainer>,
    );
  };
  ReactPrint.printSection(
    "\n\n-------------------\nGets Derived State From Props\n-------------------",
  );
  let counterRoot = Root.create();
  Root.render(
    counterRoot,
    <GetsDerivedStateFromProps txt="Foo" size=0>
      stateless
    </GetsDerivedStateFromProps>,
  );
  ReactPrint.printRoot("Init:", counterRoot);
  Root.render(
    counterRoot,
    <GetsDerivedStateFromProps txt="Foo" size=0>
      stateless
    </GetsDerivedStateFromProps>,
  );
  ReactPrint.printRoot("Update Without Changing Props:", counterRoot);
  Root.render(
    counterRoot,
    <GetsDerivedStateFromProps txt="Foo" size=8>
      stateless
    </GetsDerivedStateFromProps>,
  );
  ReactPrint.printRoot("Update With Changing Props:", counterRoot);
  ReactPrint.printSection(
    "\n\n------------------------------\nApp With Controlled Input\n------------------------------",
  );
  let appRoot = Root.create();
  Root.render(
    appRoot,
    <InputController shouldControlInput=false> stateless </InputController>,
  );
  ReactPrint.printRoot("Init:", appRoot);
  Root.render(appRoot, <InputController shouldControlInput=true />);
  ReactPrint.printRoot("Update:", appRoot);
  ReactPrint.printSection(
    "\n\n------------------------------\nApp With Request Animation Frame \n----------------------",
  );
  let animRoot = Root.create();
  Root.render(animRoot, <RequestAnimationFrameComponent txt="" />);
  ReactPrint.printRoot("Init:", animRoot);
  RequestAnimationFrame.tick();
  ReactPrint.printRoot("Update After raf tick:", animRoot);
  RequestAnimationFrame.tick();
  ReactPrint.printRoot("Update After raf tick:", animRoot);
  /* Clear this otherwise they'll show up in next loop iteration */
  RequestAnimationFrame.clearAll();
  ReactPrint.printSection(
    "\n\n------------------------------\nApp With Polymoprhic State \n----------------------------",
  );
  let polyRoot = Root.create();
  Root.render(polyRoot, <PolymorphicState anyProp="hello" size="zero" />);
  ReactPrint.printRoot("Init:", polyRoot);
  let anotherPolyRoot = Root.create();
  Root.render(anotherPolyRoot, <PolymorphicState anyProp=0 size="zero" />);
  ReactPrint.printRoot("Another Type Init:", anotherPolyRoot);
};

let endSeconds = Sys.time();

Printf.printf(
  "\nTotal ms (Title): %d\n",
  int_of_float((endSeconds -. startSeconds) *. 1000.0),
);
