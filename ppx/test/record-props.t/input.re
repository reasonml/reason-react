module Record_props = {
  [@react.component {props: string}]
  let make = (~lola) => {
    <div> {React.string(lola)} </div>;
  };
};
