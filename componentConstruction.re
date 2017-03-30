/* A */
let component = React.create ();
let create ::prop => component.create (state);

/* B */
let component = React.createComponent ();
let create ::prop => component.create (state);

/* C */
let component = ReactComponent.create ();
let create ::prop => component.create (state);

/* C.2 */
let component = React.Component.create ();
let create ::prop => component.create (state);

/* D */
let component = ReactComponent.make ();
let create ::prop => component.create (state);

/* E */
let component = React.component ();
let create ::prop => component.create (state);

/* F - Iwan suggestion */
let component = React.Component.create ();
let create ::prop => component.create (state);

/* G */
let component = React.Component.make ();
let reduce ::prop state => component.next (state, <blah />);
