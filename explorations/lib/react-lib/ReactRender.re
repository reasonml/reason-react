let suppress = {contents: false};


let rec renderInstanceCollection:
  type t. (~s: string=?, React.subtree(t)) => string =
  (~s="", subtree) => {
    let dNext = " " ++ s;
    React.(
      switch (subtree) {
      | EmptyInstance => ""
      | Instance(n) => renderInstance(~s, n)
      | Instance2(n1, n2) =>
        "\n"
        ++ dNext
        ++ renderInstanceCollection(~s=dNext, n1)
        ++ "\n"
        ++ dNext
        ++ renderInstanceCollection(~s=dNext, n2)
        ++ "\n"
        ++ s
      | Instance3(n1, n2, n3) =>
        "\n"
        ++ dNext
        ++ renderInstanceCollection(~s=dNext, n1)
        ++ "\n"
        ++ dNext
        ++ renderInstanceCollection(~s=dNext, n2)
        ++ "\n"
        ++ dNext
        ++ renderInstanceCollection(~s=dNext, n3)
        ++ "\n"
        ++ s
        ++ ")"
      | InstanceMap(lst) =>
        String.concat(
          "\n" ++ dNext,
          List.map(renderInstanceCollection(~s=dNext), lst),
        )
        ++ "\n"
      }
    );
  }

and renderInstance:
  type s a sub. (~s: string=?, React.inst((s, a) => sub)) => string =
  (~s="", n) => {
    switch (n.spec) {
    | Reducer(state, subelems, _) => renderInstanceCollection(~s, n.subtree)
    | Node(state, subelems, headerStringifier, footer) => headerStringifier()
    };
  };

let renderInstance = renderInstanceCollection;

let renderRoot: type s a sub. (string, Root.t((s, a) => sub)) => unit =
  (title, root) =>
    switch (suppress.contents, root.elemsAndInstance) {
    | (false, None) =>
      print_endline(title);
      print_endline("\n\n" ++ "<NotRendered>" ++ "\n");
    | (false, Some((elems, subtree))) =>
      print_endline("\n\n" ++ title ++ "\n");
      print_endline(renderInstanceCollection(subtree));
    | (true, _) => ()
    };
