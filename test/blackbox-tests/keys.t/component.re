module Author = {
  type t = {
    name: string,
    imageUrl: string,
  };
};

[@react.component]
let make = (~author) =>
  <tr key={author.Author.name}> <td> <img src={author.Author.imageUrl} /> </td> </tr>;
