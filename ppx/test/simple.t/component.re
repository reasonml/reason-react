module DummyStatefulComponent = {
  [@react.component]
  let make = (~initialValue=0, ()) => {
    let (value, setValue) = React.useState(() => initialValue);

    <button onClick={_ => setValue(value => value + 1)}>
      value->React.int
    </button>;
  };
};
