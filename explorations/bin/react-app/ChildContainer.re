open ReactLib;

type state = string;

type t('c) = (state, React.noAction) => Div.t('c);

let oneJsx = <Div />;

let oneJsxWithDiv = <Div> <Div /> </Div>;

/*
 * Approach that assumes identifiers are not wrapped in Count.
 * let x = <Div />
 * let x = Div.render();
 *
 * let x = <Div> <Div /> </Div>;
 * let x = Div.render(One(Div.render()));
 *
 * let y = <Div> x </Div>;    /* Demonstrates why this is hard! */
 * let y = Div.render(One(x));
 *
 * let y = <Div> x x </Div>;    /* Demonstrates why this is hard! */
 * let y = Div.render(Two(x, x)); /* Type error */
 *
 * let y = <Div> myChildren </Div>; /* Demonstrates why this is hard! */
 * let y = Div.render(myChildren);
 *
 * So that example reveals why any solution must unify any occurence of JSX
 * such that any identifier you encounter will already be assumed to be wrapped
 * in a count.
 *
 */
/*
 * How about:
 *
 * Assumptions:
 * - The most common JSX forms that are assigned to identifiers are single
 * elements.
 * - The exception to that is children.
 *
 * Desire:
 * - Allow components to be confident that when their render receives children,
 * it will be of the right JSX type.
 * - All jsx produces something of type elem, so there's no confusion.
 * - If you see an identifier mixed in JSX, the identifier is of type elem.
 * - All JSX has its count in its type, there's nothing special about nested
 * JSX, except it's not syntacticaly possible to represent > 1 without nesting.
 *
 * I will write the interpolations out explicitly.
 *
 * let x = <Div />
 * let x = One(Div.render());
 *
 * let x = <Div /> <Div />; /* Not possible to represent syntactically */
 * let x = Two(Div.render(), Div.render());
 *
 * let x = <> <Div /> <Div /> </>;
 * let x = Two(Div.render(), Div.render());
 *
 *
 * let x = <Div> <Div /> </Div>;
 * let x = One(Div.render(One(Div.render())));
 *
 * let x = <Div> <Div /> <Div /> </Div>;
 * let x = One(Div.render(Two(Div.render(), Div.render())));
 *
 * let y = <Div> {x} </Div>;
 * let y = One(Div.render(x));
 *
 * /* What does this even mean? */
 * let y = <Div> {x} {x} </Div>;
 * let y = One(Div.render(join(x, x)));
 *
 * let y = <Div> <Div /> {x} </Div>;
 * let y = One(Div.render(join(One(Div.render()), x)));
 *
 * let y = <Div> <Div /> <Div /> {x} </Div>;
 * let y = One(Div.render(join3(One(Div.render()), One(Div.render()), x)));
 *
 * let y = <Div /> {myChildren} </Div>;
 * let y = One(Div.render(myChildren));
 *
 * This one is not easy for arbitrarily shaped children.  You need to decide if
 * your component accepts single rooted children, or arbitrary forms.  If
 * single rooted, then you use join() as before. If multi rooted, then we
 * either need to model length and do algebra on length, or we need to make
 * a special JSX construct called "Nest()". If we had a Nest() then wouldn't
 * many other solutions be simpler? Perhaps, but at greater boxing and maybe
 * would be required more often.
 *
 * let y = <Div /> {myChildren} {x} </Div>;
 * let y = One(Div.render(myChildren));
 *
 */
/*
 * This one proposal extends the previous one a step further. Fixing one of the
 * remaining cases - at the expense of much boxing.
 * Every Two() must wrap each item in their count. One is a base case.
 * You could optimize away the additional wrapping if you detect all children
 * are JSX, then use a second variant leaf designd just for this.
 *
 * let x = <Div />
 * let x = One(Div.render());
 *
 * let x = <Div /> <Div />; /* Not possible to represent syntactically */
 * let x = Two(Div.render(), Div.render());
 *
 * let x = <> <Div /> <Div /> </>;
 * let x = Two(Div.render(), Div.render());
 *
 *
 * let x = <Div> <Div /> </Div>;
 * let x = One(Div.render(One(Div.render())));
 *
 * let x = <Div> <Div /> <Div /> </Div>;
 * let x = One(Div.render(Two(One(Div.render()), One(Div.render()))));
 *
 * let y = <Div> {x} </Div>;
 * let y = One(Div.render(x));
 *
 * /* What does this even mean? */
 * let y = <Div> {x} {x} </Div>;
 * let y = One(Div.render(Two(x, x)));
 *
 * let y = <Div> <Div /> {x} </Div>;
 * let y = One(Div.render(Two(One(Div.render()), x)));
 *
 * let y = <Div> <Div /> <Div /> {x} </Div>;
 * let y = One(Div.render(Three(One(Div.render()), One(Div.render()), x)));
 *
 * let y = <Div /> {myChildren} </Div>;
 * let y = One(Div.render(myChildren));
 *
 */
let theSame = <Div> oneJsx </Div>;

let theSame = <Div> oneJsx oneJsx </Div>;

let theSame = <Div> oneJsx <Div /> </Div>;

let render:
  (~txt: string=?, React.elem('childrenTree)) =>
  React.renderable(t('childrenTree)) =
  (
    ~txt="deafult",
    children: React.elem('childrenTree),
    ~state=txt,
    self: React.self(t('childrenTree)),
  ) =>
    React.Reducer(
      state,
      <> <Div className="childContainer"> children </Div> </>,
      React.nonReducer,
    );
