type noAction =
  | NoAction;

let nonReducer = _ =>
  fun
  | NoAction => "";

module Types = {
  /* This is actually needed to ensure GADTs are inferred  */
  type empty =
    | Empty_;
  /*
   * Not an ordered map yet, but should be.
   */
  /*
   * Also create another form for splicing in nodes into otherwise fixed length
   * sets.
   */
  type elem('t) =
    | Empty: elem(empty)
    | Element(renderable(('s, 'a) => 'sub)): elem(('s, 'a) => 'sub)
    | Element2(elem('t1), elem('t2)): elem(('t1, 't2))
    | Element3(elem('t1), elem('t2), elem('t3)): elem(('t1, 't2, 't3))
    /*
     * Not an ordered map yet, but should be.
     */
    | ElementMap(list(elem('t))): elem(list('t))
  /**
   * Instance subtree. Mirrors the shape of JSX, instead of just being a List.
   */
  and subtree('t) =
    | EmptyInstance: subtree(empty)
    | Instance(inst(('s, 'a) => 'sub)): subtree(('s, 'a) => 'sub)
    /* Having Instance2 mirror the fact that Element2 requires sub
     * elements, was probably overkill. */
    | Instance2(subtree('t1), subtree('t2)): subtree(('t1, 't2))
    | Instance3(subtree('t1), subtree('t2), subtree('t3))
      : subtree(('t1, 't2, 't3))
    | InstanceMap(list(subtree('t))): subtree(list('t))
  and reducer('t) = (inst('t), 'a) => 's constraint 't = ('s, 'a) => 'sub
  and headerStringifier = unit => string
  /*
   * These are just convenient shortcuts to specifiying the entire spec.  It just
   * makes it so you don't have to do a spread onto a record, since in
   * static-by-default trees, you don't need to define a record beforehand.
   */
  and componentSpec('t) =
    /* Add more forms here for convenience */
    | Reducer('s, elem('sub), reducer(('s, 'a) => 'sub))
      : componentSpec(('s, 'a) => 'sub)
    | Node('s, elem('sub), headerStringifier, /*footer*/ string)
      : componentSpec(('s, noAction) => 'sub)
  and self('t) = {
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
  constraint 't = ('s, 'a) => 'sub
  /**
   * The result of applying props. Now the result is a function that just waits
   * for React to supply the state, and in turn returns the componentSpec.
   */
  and renderable('t) = (~state: 's=?, self('t)) => componentSpec('t)
  constraint 't = ('s, 'a) => 'sub
  /*
   * TODO: Can store the subreplacer in the instance so we don't need to
   * recompute it every time.
   */
  and inst('t) = {
    /* Memoized just for performance */
    replacer: replacer('t),
    /* Memoized just for performance*/
    subreplacer: subreplacer('sub),
    self: self('t),
    renderable: renderable('t),
    spec: componentSpec('t),
    subtree: subtree('sub),
  }
  constraint 't = ('s, 'a) => 'sub
  /*
   * A series of chained functions that forms a fishing line that each component
   * has a handle to. When invoked it can cause its own individual instance node
   * in the tree to be replaced in the *root* tree that it exists in! This is
   * totally type safe, and requires no dynamic casts, and no searching through
   * the tree.
   */
  /* Make it even more generalized on action than necessary to avoid GADT
   * errors. */
  and replacer('t) = (inst('t) => inst('t)) => unit
  constraint 't = ('s, 'a) => 'sub
  and subreplacer('sub) = (subtree('sub) => subtree('sub)) => unit;
};

include Types;

let withState: type s a sub. (inst((s, a) => sub), s) => inst((s, a) => sub) =
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
    (replacer((s, a) => sub), renderable((s, a) => sub)) =>
    inst((s, a) => sub) =
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
and initSubtree: type sub. (subreplacer(sub), elem(sub)) => subtree(sub) =
  (thisReplacer, jsx) =>
    switch (jsx) {
    | Empty => EmptyInstance
    | Element(renderable) =>
      let nextReplacer = instSwapper =>
        thisReplacer((Instance(inst) as subtree) => {
          let next = instSwapper(inst);
          inst !== next ? Instance(next) : subtree;
        });
      Instance(init(nextReplacer, renderable));
    | Element2(stateRendererA, stateRendererB) =>
      let nextReplacerA = aSwapper =>
        thisReplacer((Instance2(a, b) as subtree) => {
          let next = aSwapper(a);
          next === a ? subtree : Instance2(next, b);
        });
      let nextReplacerB = bSwapper =>
        thisReplacer((Instance2(a, b) as subtree) => {
          let next = bSwapper(b);
          next === b ? subtree : Instance2(a, next);
        });
      Instance2(
        initSubtree(nextReplacerA, stateRendererA),
        initSubtree(nextReplacerB, stateRendererB),
      );
    | Element3(stateRendererA, stateRendererB, stateRendererC) =>
      let nextReplacerA = aSwapper =>
        thisReplacer((Instance3(a, b, c) as subtree) => {
          let next = aSwapper(a);
          next === a ? subtree : Instance3(next, b, c);
        });
      let nextReplacerB = bSwapper =>
        thisReplacer((Instance3(a, b, c) as subtree) => {
          let next = bSwapper(b);
          next === b ? subtree : Instance3(a, next, c);
        });
      let nextReplacerC = cSwapper =>
        thisReplacer((Instance3(a, b, c) as subtree) => {
          let next = cSwapper(c);
          next === c ? subtree : Instance3(a, b, next);
        });
      Instance3(
        initSubtree(nextReplacerA, stateRendererA),
        initSubtree(nextReplacerB, stateRendererB),
        initSubtree(nextReplacerC, stateRendererC),
      );
    | ElementMap(elems) =>
      let initElem = (i, e) => {
        let subreplacer = swapper =>
          thisReplacer((InstanceMap(iLst) as subtree) => {
            let (pre, inst, post) = StaticReactUtils.splitList(i, iLst);
            let next = swapper(inst);
            next === inst
              ? subtree : InstanceMap(List.concat([pre, [next], post]));
          });
        initSubtree(subreplacer, e);
      };
      let sub = List.mapi(initElem, elems);
      InstanceMap(sub);
    }

and reconcile:
  type s a sub.
    (inst((s, a) => sub), renderable((s, a) => sub)) => inst((s, a) => sub) =
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

and isEmptyInstance: type sub. subtree(sub) => bool =
  subtree =>
    switch (subtree) {
    | EmptyInstance => true
    | _ => false
    }

and reconcileSubtree:
  type sub. (subtree(sub), elem(sub), elem(sub)) => subtree(sub) =
  (subtree, prevJsx, jsx) =>
    switch (subtree, prevJsx, jsx) {
    | (EmptyInstance, Empty, Empty) => EmptyInstance
    | (Instance(i) as instance, Element(rPrev), Element(r)) =>
      /* No point memoizing based on return val of reconcile being === to i,
       * because it never will be if rPrev !== r. */
      false && r === rPrev ? instance : Instance(reconcile(i, r))
    | (
        Instance2(ia, ib) as _iTwo,
        Element2(raPrev, rbPrev),
        Element2(ra, rb),
      ) =>
      Instance2(
        reconcileSubtree(ia, raPrev, ra),
        reconcileSubtree(ib, rbPrev, rb),
      )
    | (
        Instance3(ia, ib, ic) as _iThree,
        Element3(raPrev, rbPrev, rcPrev),
        Element3(ra, rb, rc),
      ) =>
      Instance3(
        reconcileSubtree(ia, raPrev, ra),
        reconcileSubtree(ib, rbPrev, rb),
        reconcileSubtree(ic, rcPrev, rc),
      )
    | (InstanceMap(iLst), ElementMap(eLstPrev), ElementMap(eLst)) =>
      /* TODO: implement growing/shrinking. */
      let nextSeq =
        StaticReactUtils.mapi3(
          (i, itm, r, rPrev) => reconcileSubtree(itm, rPrev, r),
          iLst,
          eLst,
          eLstPrev,
        );
      InstanceMap(nextSeq);
    };

/**
 * Seamless control of any stateful component!
 */
let control: (elem(('s, 'a) => 'sub), ~state: 's) => elem(('s, 'a) => 'sub) =
  (Element(renderable), ~state as controlledState: 'state) =>
    Element((~state=?, self) => renderable(~state=controlledState, self));

let stateOf = inst => {
  switch (inst.spec) {
  | Reducer(curState, nextSubelems, _) => curState
  | Node(curState, nextSubelems, _, _) => curState
  };
};
