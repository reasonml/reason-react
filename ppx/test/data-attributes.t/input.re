let ordinary = <button className="button" />;

let required =
  <button
    className
    dataTestId
    onClick={event => React.Event.Mouse.preventDefault(event)}
  />;

let optional = (~className=?, ~dataFoo=?, ()) => <div ?className ?dataFoo />;

let renamed = <input type_="text" ariaLabel="name" dataFoo__bar="value" />;

let expressions = <div className={next("class")} dataFoo={next("data")} />;

let nested =
  <div dataFoo="outer">
    <span dataBar="inner" />
  </div>;

let component = <Widget dataFoo="component" />;
