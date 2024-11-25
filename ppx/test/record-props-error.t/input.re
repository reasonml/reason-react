module Record_props = {
  [@react.component {no_props: string}]
  let make = (~lola) => {
    <div> {React.string(lola)} </div>;
  };
};
