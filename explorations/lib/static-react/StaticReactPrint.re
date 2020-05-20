let suppress = {contents: false};

let emptyString = "";

let indents = [|"", " ", "  ", "   ", "    ", "     "|];

let indentNewlines = [|"\n", " \n", "  \n", "   \n", "    \n", "     \n"|];

let newlineIndents = [|"\n", "\n ", "\n  ", "\n   ", "\n    ", "\n     "|];

let dent = i => indents[i > 5 ? 5 : i];
let dentLine = i => indentNewlines[i > 5 ? 5 : i];
let lineDent = i => newlineIndents[i > 5 ? 5 : i];

/**
 * This is needed for pre-4.07 type checker.
 */
open StaticReactReact;


let rec instances:
  type t. (~nodes: bool, ~d: int, StaticReactReact.Instance.tree(t)) => string =
  (~nodes, ~d, subtree) => {
    let dNext = d + 1;
    switch (subtree) {
    | Instance.Empty => nodes ? emptyString : dent(d) ++ "</>"
    | Instance.One(n) => instance(~nodes, ~d, n)
    | Instance.Two(n1, n2) =>
      if (!nodes) {
        dent(d)
        ++ "<>\n"
        ++ instances(~nodes, ~d=dNext, n1)
        ++ "\n"
        ++ instances(~nodes, ~d=dNext, n2)
        ++ lineDent(d)
        ++ "</>";
      } else {
        instances(~nodes, ~d, n1) ++ "\n" ++ instances(~nodes, ~d, n2);
      }
    | Instance.Three(n1, n2, n3) =>
      if (!nodes) {
        dent(d)
        ++ "<>"
        ++ "\n"
        ++ instances(~nodes, ~d=dNext, n1)
        ++ "\n"
        ++ instances(~nodes, ~d=dNext, n2)
        ++ "\n"
        ++ instances(~nodes, ~d=dNext, n3)
        ++ lineDent(d)
        ++ "</>";
      } else {
        dentLine(d)
        ++ instances(~nodes, ~d, n1)
        ++ "\n"
        ++ instances(~nodes, ~d, n2)
        ++ "\n"
        ++ instances(~nodes, ~d, n3);
      }    | Instance.Map(lst) =>
      dent(d)
      ++ "Instance.Map("
      ++ String.concat(",", List.map(instances(~nodes, ~d=dNext), lst))
      ++ ")"
    };
  }

and printState: Obj.t => string =
  state =>
    Obj.is_int(state)
      ? string_of_int(Obj.magic(state): int)
      : Obj.tag(state) === Obj.string_tag
          ? "\"" ++ String.escaped(Obj.magic(state): string) ++ "\"" : "?"
and instance:
  type s a sub.
    (~nodes: bool, ~d: int, StaticReactReact.inst((s, a) => sub)) => string =
  (~nodes, ~d, n) => {
    let dNext = d + 1;
    switch (nodes, n.spec) {
    | (false, Reducer(state, subelems, _)) =>
      let stateO: Obj.t = Obj.magic(state);
      let stateS = printState(stateO);
      let tail = lineDent(d) ++ "</instance>";
      let bodyAndTail =
        StaticReactReact.Instance.isEmpty(n.subtree)
          ? tail : instances(~nodes, ~d=dNext, n.subtree) ++ tail;
      let line1 = "<instance\n" ++ dent(dNext) ++ "state=" ++ stateS ++ ">\n";
      dent(d) ++ line1 ++ bodyAndTail;
    | (true, Reducer(state, subelems, _)) =>
      instances(~nodes, ~d, n.subtree)
    | (_, Node(state, subelems, headerStringifier, footer)) =>
      let header = headerStringifier();
      StaticReactReact.Instance.isEmpty(n.subtree)
        ? dent(d) ++ header ++ footer
        : dent(d)
          ++ header
          ++ "\n"
          ++ instances(~nodes, ~d=d + 1, n.subtree)
          ++ lineDent(d)
          ++ footer;
    };
  };

let printSection = s =>
  if (suppress.contents) {
    ();
  } else {
    print_endline("\n\n" ++ s);
  };

let printRoot:
  type s a sub. (~title: string, StaticReactRoot.t((s, a) => sub)) => unit =
  (~title, root) =>
    switch (suppress.contents, root.elemsAndInstance) {
    | (false, None) =>
      print_endline(title);
      print_endline("\n\n" ++ "<NotRendered>" ++ "\n");
    | (false, Some((elems, subtree))) =>
      print_endline("\n\n" ++ title ++ " Verbose\n");
      print_endline(instances(~nodes=false, ~d=0, subtree));
      print_endline("\n\n" ++ title ++ " Nodes Only\n");
      print_endline(instances(~nodes=true, ~d=0, subtree));
    | (true, _) => ()
    };
