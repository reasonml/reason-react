type noAction =
  | NoAction;

let nonReducer = (_) =>
  fun
  | NoAction => "";

module Types = {
  /* This is actually needed to ensure GADTs are inferred  */
  type empty =
    | Empty_;
  /*
   * Also create another form for splicing in nodes into otherwise fixed length
   * sets.
   */
  type elem('t) =
    | Empty: elem(empty)
    | Element(renderable(('s, 'a) => 'sub)): elem(('s, 'a) => 'sub)
    | TwoElements(elem('t1), elem('t2)): elem(('t1, 't2))
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
    /* Having TwoInstances mirror the fact that TwoElements requires sub
     * elements, was probably overkill. */
    | TwoInstances(subtree('t1), subtree('t2)): subtree(('t1, 't2))
    | InstanceMap(list(subtree('t))): subtree(list('t))
  and reducer('t) = (inst('t), 'a) => 's constraint 't = ('s, 'a) => 'sub
  /*
   * These are just convenient shortcuts to specifiying the entire spec.  It just
   * makes it so you don't have to do a spread onto a record, since in
   * static-by-default trees, you don't need to define a record beforehand.
   */
  and componentSpec('t) =
    /* Add more forms here for convenience */
    | Reducer('s, elem('sub), reducer('t))
  constraint 't = ('s, 'a) => 'sub
  and self('t) = {
    reduceEvent: 'e .('e => 'a, 'e) => unit,
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

let withState = (inst, nextState) => {
  let Reducer(_, subElems, reducer) = inst.spec;
  {...inst, spec: Reducer(nextState, subElems, reducer)};
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
          let Reducer(_, _, reducer) = inst.spec;
          let nextState = reducer(inst, action);
          reconcile(withState(inst, nextState), inst.renderable);
        });
      },
      send: action =>
        replacer(inst => {
          let Reducer(_, _, reducer) = inst.spec;
          let nextState = reducer(inst, action);
          reconcile(withState(inst, nextState), inst.renderable);
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
    let Reducer(_, subelems, _) as nextSpec = renderable(~state=?None, self);
    {
      self,
      replacer,
      subreplacer,
      renderable,
      spec: nextSpec,
      subtree: initSubtree(subreplacer, subelems),
    };
  }
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
    | TwoElements(stateRendererA, stateRendererB) =>
      let nextReplacerA = aSwapper =>
        thisReplacer((TwoInstances(a, b) as subtree) => {
          let next = aSwapper(a);
          next === a ? subtree : TwoInstances(next, b);
        });
      let nextReplacerB = bSwapper =>
        thisReplacer((TwoInstances(a, b) as subtree) => {
          let next = bSwapper(b);
          next === b ? subtree : TwoInstances(a, next);
        });
      TwoInstances(
        initSubtree(nextReplacerA, stateRendererA),
        initSubtree(nextReplacerB, stateRendererB),
      );
    | ElementMap(elems) =>
      let initElem = (i, e) => {
        let subreplacer = swapper =>
          thisReplacer((InstanceMap(iLst) as subtree) => {
            let (pre, inst, post) = Utils.splitList(i, iLst);
            let next = swapper(inst);
            next === inst ?
              subtree : InstanceMap(List.concat([pre, [next], post]));
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
    let Reducer(curState, curSubelems, _) = inst.spec;
    let nextSpec = renderable(~state=curState, inst.self);
    let Reducer(_, nextSubelems, _) = nextSpec;
    {
      ...inst,
      renderable,
      spec: nextSpec,
      subtree: reconcileSubtree(inst.subtree, curSubelems, nextSubelems),
    };
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
        TwoInstances(ia, ib) as _iTwo,
        TwoElements(raPrev, rbPrev),
        TwoElements(ra, rb),
      ) =>
      TwoInstances(
        reconcileSubtree(ia, raPrev, ra),
        reconcileSubtree(ib, rbPrev, rb),
      )
    | (InstanceMap(iLst), ElementMap(eLstPrev), ElementMap(eLst)) =>
      /* TODO: implement growing/shrinking. */
      let nextSeq =
        Utils.mapi3(
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
  let Reducer(state, _, _) = inst.spec;
  state;
};
