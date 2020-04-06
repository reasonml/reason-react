/**
 * Simple utility for managing a single top level mutable cell where
 * React trees live.
 */
type t('t) = {
  replacer: StaticReact.subreplacer('t),
  /* Only maintains roots for One() elements. */
  mutable elemsAndInstance:
    option
      /* Since a root is not an instance, but we need the prev elems. */
      ((StaticReact.elem('s => 'sub), StaticReact.subtree('s => 'sub))),
}
constraint 't = 's => 'sub;

let create = () => {
  let rec root = {
    replacer: swapper =>
      switch (root.elemsAndInstance) {
      | None => raise(Invalid_argument("Impossible"))
      | Some(ei) =>
        let (curElems, curInst) = ei;
        let nextEi = (curElems, swapper(curInst));
        root.elemsAndInstance = Some(nextEi);
      },
    elemsAndInstance: None,
  };
  root;
};

let clear = root => root.elemsAndInstance = None;

/**
 * The most likely to be used publicly. Rendering with a single One() JSX.
 */
let render = (root, elems: StaticReact.elem('s => 'sub)) =>
  switch (root.elemsAndInstance) {
  | None =>
    let nextEi = (elems, StaticReact.initSubtree(root.replacer, elems));
    root.elemsAndInstance = Some(nextEi);
  | Some(ei) =>
    let (curElems, curSubtree) = ei;
    let nextEi = (
      elems,
      StaticReact.reconcileSubtree(curSubtree, curElems, elems),
    );
    root.elemsAndInstance = Some(nextEi);
  };
