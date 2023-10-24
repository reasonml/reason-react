module Component = {
  [@react.component]
  let make = (~author) =>
    <tr key="key">
      <td> <span> {React.string(author)} {React.int(33)} </span> </td>
    </tr>;
};
