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
