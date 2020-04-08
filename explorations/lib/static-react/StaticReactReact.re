/**
 * Core Static React module. Use like this:
 * Usage:
 *
 *   open StaticReact;
 *   React.Reducer()
 *
 */
/* This is actually needed to ensure GADTs are inferred  */
type empty =
  | Empty_;

module type Node = {type node('t) constraint 't = ('state, 'action) => 'sub;};
module Tree = {
  module Make = (Node: Node) => {
    type node('t) = Node.node('t) constraint 't = ('state, 'action) => 'sub;
    type tree('t) =
      | Empty: tree(empty)
      | One(node('a)): tree('a)
      | Two(tree('a), tree('b)): tree(('a, 'b))
      | Three(tree('a), tree('b), tree('c)): tree(('a, 'b, 'c))
      | Map(list(tree('t))): tree(list('t));

    let isEmpty: type sub. tree(sub) => bool =
      subtree =>
        switch (subtree) {
        | Empty => true
        | _ => false
        };
  };
};
/**
 * The result of applying props. Now the result is a function that just waits
 * for React to supply the state, and in turn returns the componentSpec.
 */
module rec Element: {
  type node('t) = Types.renderable('t) constraint 't = ('s, 'a) => 'sub;
  type tree('t) =
    | Empty: tree(empty)
    | One(node('a)): tree('a)
    | Two(tree('a), tree('b)): tree(('a, 'b))
    | Three(tree('a), tree('b), tree('c)): tree(('a, 'b, 'c))
    | Map(list(tree('t))): tree(list('t));

  let isEmpty: tree('sub) => bool;
} =
  Tree.Make({
    type node('t) = Types.renderable('t) constraint 't = ('s, 'a) => 'sub;
  })

and Instance: {
  type node('t) = Types.inst('t);
  type tree('t) =
    | Empty: tree(empty)
    | One(node('a)): tree('a)
    | Two(tree('a), tree('b)): tree(('a, 'b))
    | Three(tree('a), tree('b), tree('c)): tree(('a, 'b, 'c))
    | Map(list(tree('t))): tree(list('t));
  let isEmpty: tree('sub) => bool;
} =
  Tree.Make({
    type node('t) = Types.inst('t);
  })
and Types: {
  type elem('t) = Element.tree('t);
  type noAction =
    | NoAction;
  type self('t) = {
    reduceEvent: 'e. ('e => 'a, 'e) => unit,
    /**
     * Implements the ability to cause your node to be swapped out from within
     * its tree. Not purely functional by design. This is for things like
     * external subscriptions that don't arive via propagations through the tree.
     * However, this is better than simple naive mutation. That's because this
     * "out of nowhere" operation notifies the root of the tree that it should
     * perform a mutation. That allows the root to create an entirely new
     * reference, leaving the previous tree completely in tact! There isn't a
     * single mutable reference cell in the entire tree - only the root node is
     * mutable, and even then it doesn't have to be.
     *
     * This Api takes highly imperative operations like request animation frame,
     * and allows them to work well with what would otherwise be a purely
     * functional data structure (aside from the side effects caused by
     * subscribing upon mount etc).
     */
    send: 'a => unit,
  }
  constraint 't = ('s, 'a) => 'sub;
  type renderable('t) = (~state: 's=?, self('t)) => componentSpec('t)
  constraint 't = ('s, 'a) => 'sub
  /*
   * These are just convenient shortcuts to specifiying the entire spec.  It just
   * makes it so you don't have to do a spread onto a record, since in
   * static-by-default trees, you don't need to define a record beforehand.
   */
  and componentSpec('t) =
    /* Add more forms here for convenience */
    | Reducer('s, Element.tree('sub), reducer(('s, 'a) => 'sub))
      : componentSpec(('s, 'a) => 'sub)
    | Node('s, Element.tree('sub), headerStringifier, /*footer*/ string)
      : componentSpec(('s, noAction) => 'sub)
  and inst('t) = {
    /* Memoized just for performance */
    replacer: replacer('t),
    /* Memoized just for performance*/
    subreplacer: subreplacer('sub),
    self: self('t),
    renderable: Element.node('t),
    spec: componentSpec('t),
    subtree: Instance.tree('sub),
  }
  constraint 't = ('s, 'a) => 'sub
  /*
   * TODO: Can store the subreplacer in the instance so we don't need to
   * recompute it every time.
   */
  and reducer('t) = (Instance.node('t), 'a) => 's
  constraint 't = ('s, 'a) => 'sub
  and headerStringifier = unit => string
  /*
   * A series of chained functions that forms a fishing line that each component
   * has a handle to. When invoked it can cause its own individual instance node
   * in the tree to be replaced in the *root* tree that it exists in! This is
   * totally type safe, and requires no dynamic casts, and no searching through
   * the tree.
   */
  /* Make it even more generalized on action than necessary to avoid GADT
   * errors. */
  and replacer('t) = (Instance.node('t) => Instance.node('t)) => unit
  constraint 't = ('s, 'a) => 'sub
  and subreplacer('sub) =
    (Instance.tree('sub) => Instance.tree('sub)) => unit;
} = Types;

include Types;

let nonReducer = _ =>
  fun
  | NoAction => "";

let withState:
  type s a sub.
    (Instance.node((s, a) => sub), s) => Instance.node((s, a) => sub) =
  (inst, nextState) => {
    switch (inst.spec) {
    | Reducer(_, subElems, reducer) => {
        ...inst,
        spec: Reducer(nextState, subElems, reducer),
      }
    | Node(_, subElems, headerStringifier, footer) => {
        ...inst,
        spec: Node(nextState, subElems, headerStringifier, footer),
      }
    };
  };


let rec newSelf:
  type s a sub.
    (replacer((s, a) => sub), subreplacer(sub)) => self((s, a) => sub) =
  (replacer, subreplacer) => {
    let rec self = {
      /* Allows reducing an event into an action, with full refs access. */
      reduceEvent: (actionExtractor, ev) => {
        let action = actionExtractor(ev);
        replacer(inst => {
          switch (inst.spec) {
          | Reducer(_, _, reducer) =>
            let nextState = reducer(inst, action);
            reconcile(withState(inst, nextState), inst.renderable);
          | Node(_) => inst
          }
        });
      },
      send: action =>
        replacer(inst => {
          switch (inst.spec) {
          | Reducer(_, _, reducer) =>
            let nextState = reducer(inst, action);
            reconcile(withState(inst, nextState), inst.renderable);
          | Node(_) => inst
          }
        }),
    };
    self;
  }

and init:
  type s a sub.
    (replacer((s, a) => sub), Element.node((s, a) => sub)) =>
    Instance.node((s, a) => sub) =
  (replacer, renderable) => {
    /* Causes a chain reaction until it hits the root! */
    let subreplacer = subtreeSwapper =>
      replacer(inst => {
        let nextSubtree = subtreeSwapper(inst.subtree);
        inst.subtree !== nextSubtree ? {...inst, subtree: nextSubtree} : inst;
      });
    let self = newSelf(replacer, subreplacer);
    let (subelems, nextSpec) =
      switch (renderable(~state=?None, self)) {
      | Reducer(_, subelems, _) as nextSpec => (subelems, nextSpec)
      | Node(_, subelems, _, _) as nextSpec => (subelems, nextSpec)
      };
    {
      self,
      replacer,
      subreplacer,
      renderable,
      spec: nextSpec,
      subtree: initSubtree(subreplacer, subelems),
    };
  }

/*
 * TODO: Do not need to reallocate `InstanceN` when `next` is `===`.
 */
and initSubtree:
  type sub. (subreplacer(sub), Element.tree(sub)) => Instance.tree(sub) =
  (thisReplacer, jsx) =>
    switch (jsx) {
    | Element.Empty => Instance.Empty
    | Element.One(renderable) =>
      let nextReplacer = instSwapper =>
        thisReplacer((Instance.One(inst) as subtree) => {
          let next = instSwapper(inst);
          inst !== next ? Instance.One(next) : subtree;
        });
      Instance.One(init(nextReplacer, renderable));
    | Element.Two(stateRendererA, stateRendererB) =>
      let nextReplacerA = aSwapper =>
        thisReplacer((Instance.Two(a, b) as subtree) => {
          let next = aSwapper(a);
          next === a ? subtree : Instance.Two(next, b);
        });
      let nextReplacerB = bSwapper =>
        thisReplacer((Instance.Two(a, b) as subtree) => {
          let next = bSwapper(b);
          next === b ? subtree : Instance.Two(a, next);
        });
      Instance.Two(
        initSubtree(nextReplacerA, stateRendererA),
        initSubtree(nextReplacerB, stateRendererB),
      );
    | Element.Three(stateRendererA, stateRendererB, stateRendererC) =>
      let nextReplacerA = aSwapper =>
        thisReplacer((Instance.Three(a, b, c) as subtree) => {
          let next = aSwapper(a);
          next === a ? subtree : Instance.Three(next, b, c);
        });
      let nextReplacerB = bSwapper =>
        thisReplacer((Instance.Three(a, b, c) as subtree) => {
          let next = bSwapper(b);
          next === b ? subtree : Instance.Three(a, next, c);
        });
      let nextReplacerC = cSwapper =>
        thisReplacer((Instance.Three(a, b, c) as subtree) => {
          let next = cSwapper(c);
          next === c ? subtree : Instance.Three(a, b, next);
        });
      Instance.Three(
        initSubtree(nextReplacerA, stateRendererA),
        initSubtree(nextReplacerB, stateRendererB),
        initSubtree(nextReplacerC, stateRendererC),
      );
    | Element.Map(elems) =>
      let initElem = (i, e) => {
        let subreplacer = swapper =>
          thisReplacer((Instance.Map(iLst) as subtree) => {
            let (pre, inst, post) = StaticReactUtils.splitList(i, iLst);
            let next = swapper(inst);
            next === inst
              ? subtree : Instance.Map(List.concat([pre, [next], post]));
          });
        initSubtree(subreplacer, e);
      };
      let sub = List.mapi(initElem, elems);
      Instance.Map(sub);
    }

and reconcile:
  type s a sub.
    (Instance.node((s, a) => sub), Element.node((s, a) => sub)) =>
    Instance.node((s, a) => sub) =
  (inst, renderable) => {
    let (curState, curSubelems) =
      switch (inst.spec) {
      | Reducer(curState, curSubelems, _) => (curState, curSubelems)
      | Node(curState, curSubelems, _, _) => (curState, curSubelems)
      };
    let (nextSubelems, nextSpec) =
      switch (renderable(~state=curState, inst.self)) {
      | Reducer(curState, nextSubelems, _) as nextSpec => (
          nextSubelems,
          nextSpec,
        )
      | Node(curState, nextSubelems, _, _) as nextSpec => (
          nextSubelems,
          nextSpec,
        )
      };
    {
      ...inst,
      renderable,
      spec: nextSpec,
      subtree: reconcileSubtree(inst.subtree, curSubelems, nextSubelems),
    };
  }

and reconcileSubtree:
  type sub.
    (Instance.tree(sub), Element.tree(sub), Element.tree(sub)) =>
    Instance.tree(sub) =
  (subtree, prevJsx, jsx) =>
    switch (subtree, prevJsx, jsx) {
    | (Instance.Empty, Element.Empty, Element.Empty) => Instance.Empty
    | (Instance.One(i) as instance, Element.One(rPrev), Element.One(r)) =>
      /* No point memoizing based on return val of reconcile being === to i,
       * because it never will be if rPrev !== r. */
      false && r === rPrev ? instance : Instance.One(reconcile(i, r))
    | (Instance.Two(ia, ib) as _iTwo, Two(raPrev, rbPrev), Two(ra, rb)) =>
      Instance.Two(
        reconcileSubtree(ia, raPrev, ra),
        reconcileSubtree(ib, rbPrev, rb),
      )
    | (
        Instance.Three(ia, ib, ic) as _iThree,
        Three(raPrev, rbPrev, rcPrev),
        Three(ra, rb, rc),
      ) =>
      Instance.Three(
        reconcileSubtree(ia, raPrev, ra),
        reconcileSubtree(ib, rbPrev, rb),
        reconcileSubtree(ic, rcPrev, rc),
      )
    | (Instance.Map(iLst), Element.Map(eLstPrev), Element.Map(eLst)) =>
      /* TODO: implement growing/shrinking. */
      let nextSeq =
        StaticReactUtils.mapi3(
          (i, itm, r, rPrev) => reconcileSubtree(itm, rPrev, r),
          iLst,
          eLst,
          eLstPrev,
        );
      Instance.Map(nextSeq);
    };

/**
 * Seamless control of any stateful component!
 */
let control:
  (Element.tree(('s, 'a) => 'sub), ~state: 's) =>
  Element.tree(('s, 'a) => 'sub) =
  (Element.One(renderable), ~state as controlledState: 'state) =>
    Element.One(
      (~state=?, self) => renderable(~state=controlledState, self),
    );

let stateOf = inst => {
  switch (inst.spec) {
  | Reducer(curState, nextSubelems, _) => curState
  | Node(curState, nextSubelems, _, _) => curState
  };
};
