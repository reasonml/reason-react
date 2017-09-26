module GlobalState = {
  let debug = ref true;
  let componentIDCounter = ref 0;
  let instanceIdCounter = ref 0;
  let reset () => {
    debug := true;
    componentIDCounter := 0;
    instanceIdCounter := 1 /* id 0 reserved for defaultStringInstance */
  };
  /*
   * Use physical equality to recognize that an element was added to the list of children.
   * Note: this currently does not check for pending updates on components in the list.
   */
  let useTailHack = ref false;
};

type sideEffects = unit => unit;

type stateless = unit;

type actionless = unit;

module Callback = {
  type t 'payload = 'payload => unit;
  let default _event => ();
  let chain handlerOne handlerTwo payload => {
    handlerOne payload;
    handlerTwo payload
  };
};

type reduce 'payload 'action = ('payload => 'action) => Callback.t 'payload;

type update 'state 'action =
  | NoUpdate
  | Update 'state
and self 'state 'action = {
  state: 'state,
  reduce: 'payload .reduce 'payload 'action
}
/**
 * Elements are what JSX blocks become. They represent the *potential* for a
 * component instance and state to be created / updated. They are not yet
 * instances.
 */
and element =
  | Element (component 'state 'action) :element
  | String string :element
/**
 * We will want to replace this with a more efficient data structure.
 */
and reactElement =
  | Flat (list element)
  | Nested string (list reactElement)
and renderedElement =
  | IFlat (list instanceTree)
  | INested string (list renderedElement)
and oldNewSelf 'state 'action = {
  oldSelf: self 'state 'action,
  newSelf: self 'state 'action
}
and componentSpec 'state 'initialState 'action = {
  debugName: string,
  willReceiveProps: self 'state 'action => 'state,
  didMount: self 'state 'action => update 'state 'action /* TODO: currently unused */,
  didUpdate: oldNewSelf 'state 'action => unit /* TODO: currently unused */,
  willUnmount: self 'state 'action => unit /* TODO: currently unused */,
  willUpdate: oldNewSelf 'state 'action => unit /* TODO: currently unused */,
  shouldUpdate: oldNewSelf 'state 'action => bool /* TODO: currently unused */,
  render: self 'state 'action => reactElement,
  initialState: unit => 'initialState,
  reducer: 'action => 'state => update 'state 'action,
  printState: 'state => string /* for internal debugging */,
  handedOffInstance: ref (option (instance 'state 'action)) /* Used to avoid Obj.magic in update */,
  cID: int
}
and component 'state 'action = componentSpec 'state 'state 'action
/**
 * Elements turn into instances at the right time. These instances record the
 * most recent state among other things.
 */
and instance 'state 'action = {
  component: component 'state 'action,
  /**
   * This may not be a good idea to hold onto for sake of memory, but it makes
   * it convenient to implement shouldComponentUpdate.
   */
  element,
  iState: 'state,
  /**
   * Most recent subtree of instances.
   */
  instanceSubTree: renderedElement,
  subElements: reactElement,
  /**
   * List of state updates pending for this instance.
   * Stored in reverse order.
   */
  pendingStateUpdates: ref (list ('state => update 'state 'action)),
  /**
   * Unique instance id.
   * */
  id: int
}
/**
 * The result of "rendering" an Element, is a tree of instances that are
 * produced. This tree is then updated to produce a new *version* of the
 * instance tree based on the old - the old one is not mutated.
 */
and instanceTree =
  | InstanceTree (instance 'state 'action) :instanceTree;

let logString txt =>
  !GlobalState.debug ?
    {
      print_string txt;
      print_newline ()
    } :
    ();

let defaultPrintState _state => "";

type cID = int;

let noCID = (-1);

let firstCID = 0;

let createCID () => {
  incr GlobalState.componentIDCounter;
  !GlobalState.componentIDCounter
};

let basicComponent ::useCID=false debugName :componentSpec _ stateless _ => {
  let cID = useCID ? firstCID : noCID;
  {
    debugName,
    willReceiveProps: fun {state} => state,
    didMount: fun _self => NoUpdate,
    didUpdate: fun _oldNewSef => (),
    willUnmount : fun _self => (),
    willUpdate: fun _oldNewSef => (),
    shouldUpdate: fun _oldNewSef => true,
    render: fun _self => assert false,
    initialState: fun () => (),
    reducer: fun _action _state => NoUpdate,
    printState: defaultPrintState,
    handedOffInstance: ref None,
    cID
  }
};


/** Tail-recursive functions on lists */
module ListTR = {
  let useTailRecursion l =>
    switch l {
    | [_, _, _, _, _, _, _, _, _, _, ..._] => true
    | _ => false
    };
  let concat list => {
    let rec aux acc l =>
      switch l {
      | [] => List.rev acc
      | [x, ...rest] => aux (List.rev_append x acc) rest
      };
    useTailRecursion list ? aux [] list : List.concat list
  };
  let map f list => useTailRecursion list ? List.rev_map f (List.rev list) : List.map f list;
  let rev_map3 f list1 list2 list3 => {
    let rec aux acc =>
      fun
      | ([], [], []) => acc
      | ([x1, ...nextList1], [x2, ...nextList2], [x3, ...nextList3]) =>
        aux [f (x1, x2, x3), ...acc] (nextList1, nextList2, nextList3)
      | _ => assert false;
    aux [] (list1, list2, list3)
  };
  let map3 f list1 list2 list3 => rev_map3 f (List.rev list1) (List.rev list2) (List.rev list3);
};


/** Log of operations performed to update an instance tree. */
module UpdateLog = {
  type update = {
    oldId: int,
    newId: int,
    oldInstanceTree: instanceTree,
    newInstanceTree: instanceTree,
    componentChanged: bool,
    stateChanged: bool,
    subTreeChanged: bool
  };
  type entry =
    | UpdateInstance update
    | NewRenderedElement renderedElement;
  type t = ref (list entry);
  let create () => ref [];
  let add updateLog x => updateLog := [x, ...!updateLog];
};

module Render = {
  let createSelf ::instance :self _ => {
    state: instance.iState,
    reduce: fun payloadToAction payload => {
      logString ("Calling reduce on " ^ instance.component.debugName);
      let action = payloadToAction payload;
      let stateUpdate = instance.component.reducer action;
      instance.pendingStateUpdates := [stateUpdate, ...!instance.pendingStateUpdates]
    }
  };
  let createInstance ::component ::element ::instanceSubTree ::subElements => {
    let iState = component.initialState ();
    let id = !GlobalState.instanceIdCounter;
    incr GlobalState.instanceIdCounter;
    {component, element, iState, instanceSubTree, subElements, pendingStateUpdates: ref [], id}
  };
  let defaultStringInstance =
    createInstance
      component::(basicComponent "String")
      element::(String "")
      instanceSubTree::(IFlat [])
      subElements::(Flat []);
  let rec flattenReactElement =
    fun
    | Flat l => l
    | Nested _ l => ListTR.concat (ListTR.map flattenReactElement l);
  let rec flattenRenderedElement =
    fun
    | IFlat l => l
    | INested _ l => ListTR.concat (ListTR.map flattenRenderedElement l);
  let rec mapReactElement f reactElement =>
    switch reactElement {
    | Flat l => IFlat (ListTR.map f l)
    | Nested s l => INested s (ListTR.map (mapReactElement f) l)
    };
  let rec mapRenderedElement f renderedElement =>
    switch renderedElement {
    | IFlat l =>
      let nextL = ListTR.map f l;
      let unchanged = List.for_all2 (===) l nextL;
      unchanged ? renderedElement : IFlat nextL
    | INested s l =>
      let nextL = ListTR.map (mapRenderedElement f) l;
      let unchanged = List.for_all2 (===) l nextL;
      unchanged ? renderedElement : INested s nextL
    };
  module InstanceTreeHash = {
    let addInstanceTrees idTable instanceTrees => {
      let add instanceTree => {
        let InstanceTree {component: {cID}} = instanceTree;
        cID == noCID ? () : Hashtbl.add idTable cID instanceTree
      };
      List.iter add instanceTrees
    };
    let createPositionTable instanceTrees => {
      let posTable = Hashtbl.create 1;
      let add i instanceTree => Hashtbl.add posTable i instanceTree;
      List.iteri add instanceTrees;
      posTable
    };
    let addRenderedElement idTable renderedElement => {
      let rec aux =
        fun
        | IFlat l => addInstanceTrees idTable l
        | INested _ l => List.iter aux l;
      aux renderedElement
    };
    let createCIDTable renderedElement =>
      lazy {
        let idTable = Hashtbl.create 1;
        addRenderedElement idTable renderedElement;
        idTable
      };
    let lookupCID table cID => {
      let idTable = Lazy.force table;
      try (Some (Hashtbl.find idTable cID)) {
      | Not_found => None
      }
    };
    let lookupPosition posTable i =>
      try (Some (Hashtbl.find posTable i)) {
      | Not_found => None
      };
  };

  /**
   * Initial render of an Element. Recurses to produce the entire tree of
   * instances.
   */
  let rec renderElement ::useIdTable=? element :instanceTree =>
    switch element {
    | Element component =>
      let instanceTreeFromCid =
        switch useIdTable {
        | None => None
        | Some idTable => InstanceTreeHash.lookupCID idTable component.cID
        };
      switch instanceTreeFromCid {
      | Some instanceTree => instanceTree
      | None =>
        let instance =
          createInstance ::component ::element instanceSubTree::(IFlat []) subElements::(Flat []);
        let self = createSelf ::instance;
        let reactElement = component.render self;
        let length =
          switch reactElement {
          | Flat elements => List.length elements
          | Nested _ reactElements => List.length reactElements
          };
        logString (
          Printf.sprintf
            "Creating instance #%d of %s with %d subelements"
            instance.id
            component.debugName
            length
        );
        let instanceSubTree = renderReactElement reactElement;
        InstanceTree {...instance, instanceSubTree, subElements: reactElement}
      }
    | String s => InstanceTree {...defaultStringInstance, element: String s}
    }
  and renderReactElement ::useIdTable=? reactElement :renderedElement =>
    mapReactElement (renderElement ::?useIdTable) reactElement;

  /**
   * Update a previously rendered instance tree according to a new Element.
   *
   * Here's where the magic happens:
   * -------------------------------
   *
   * We perform a dynamic check that two types are statically equal by way of
   * mutation! We have a value of type `InstanceTree` and another of type
   * `Element`, where we each has their own `component 'x` for potentially
   * different 'x. We need to see if the 'x are the same and if so safely "cast"
   * one's `component` to the others. We do this by handing off state safely into
   * one of their `component`s, and then seeing if we can observe it in the
   * other, and if so, we simply treat the old component as the new one's.
   *
   * This approach is as sound as our confidence in our ability to repair the
   * mutations accurately.
   *
   * There are more elegant ways to do this using first class modules, combined
   * with extensible variants. That is how we should do this if we want to turn
   * this implementation into something serious - it would avoid hitting the
   * write barrier.
   */
  let rec update ::updateInstanceTreeState=? ::updateLog instanceTree nextElement :instanceTree => {
    let updatedInstanceTree =
      switch updateInstanceTreeState {
      | Some f => f instanceTree
      | None => instanceTree
      };
    let stateNotUpdated = instanceTree === updatedInstanceTree;
    let bailOut = {
      let InstanceTree {element, component} = instanceTree;
      let log () => {
        logString ("Bailing Out Early Due To Memoization on " ^ component.debugName);
        true
      };
      stateNotUpdated && element === nextElement && log ()
    };
    let logUpdate ::componentChanged ::stateChanged ::subTreeChanged newInstanceTree => {
      let InstanceTree {id} = instanceTree;
      let InstanceTree {id: newId} = newInstanceTree;
      let comp = componentChanged ? " component" : "";
      let st = stateChanged ? " state" : "";
      let sub = subTreeChanged ? " subtree" : "";
      UpdateLog.add
        updateLog
        (
          UpdateLog.UpdateInstance {
            oldId: id,
            newId,
            oldInstanceTree: instanceTree,
            newInstanceTree,
            componentChanged,
            stateChanged,
            subTreeChanged
          }
        );
      logString (
        Printf.sprintf "instance #%d updated to instance #%d changed:%s%s%s" id newId comp st sub
      )
    };
    if bailOut {
      instanceTree
    } else {
      let InstanceTree ({component, instanceSubTree, subElements} as updatedInstance) = updatedInstanceTree;
      switch nextElement {
      | Element nextComponent =>
        component.handedOffInstance := Some updatedInstance;
        switch !nextComponent.handedOffInstance {
        /*
         * Case A: The next element *is* of the same component class.
         */
        | Some nextComponentInstance =>
          /* DO NOT FORGET TO RESET HANDEDOFFINSTANCE */
          component.handedOffInstance := None;
          logString ("Updating " ^ nextComponent.debugName);
          let instance = {
            ...nextComponentInstance,
            component: nextComponent,
            element: nextElement
          };
          let self = createSelf ::instance;
          let nextState = nextComponent.willReceiveProps self;
          let nextInstance = {...instance, iState: nextState};
          let nextSelf = createSelf instance::nextInstance;
          let nextSubElements = nextComponent.render nextSelf;
          /* TODO: Invoke any lifecycles necessary. */
          let nextInstanceSubTree =
            updateRenderedElement
              ::?updateInstanceTreeState
              ::updateLog
              (instanceSubTree, subElements, nextSubElements);
          let newInstanceTree =
            InstanceTree {
              ...nextInstance,
              instanceSubTree: nextInstanceSubTree,
              subElements: nextSubElements
            };
          let stateChanged =
            /* We need to split up the check for state changes in two parts.
               The first part covers pending updates.
               The second part covers changes during case A processing. */
            not stateNotUpdated || nextState !== nextComponentInstance.iState;
          let subTreeChanged = {
            let InstanceTree {instanceSubTree} = instanceTree;
            nextInstanceSubTree !== instanceSubTree
          };
          logUpdate componentChanged::false ::stateChanged ::subTreeChanged newInstanceTree;
          newInstanceTree
        /*
         * Case B: The next element is *not* of the same component class. We know
         * because otherwise we would have observed the mutation on
         * `nextComponentClass`.
         */
        | None =>
          /* DO NOT FORGET TO RESET HANDEDOFFINSTANCE */
          component.handedOffInstance := None;
          let nextInstance =
            createInstance
              component::nextComponent element::nextElement ::instanceSubTree ::subElements;
          let self = createSelf instance::nextInstance;
          let nextSubElements = nextComponent.render self;
          logString (
            Printf.sprintf
              "Switching Component Types from: %s to %s"
              component.debugName
              nextComponent.debugName
          );
          /* TODO: Invoke destruction lifecycle on previous component. */
          /* TODO: Invoke creation lifecycle on next component. */
          let nextSubtree = renderReactElement nextSubElements;
          let newInstanceTree =
            InstanceTree {
              ...nextInstance,
              instanceSubTree: nextSubtree,
              subElements: nextSubElements
            };
          logUpdate componentChanged::true stateChanged::true subTreeChanged::true newInstanceTree;
          newInstanceTree
        }
      | String s => InstanceTree {...defaultStringInstance, element: String s}
      }
    }
  }
  and updateRenderedElement
      ::updateInstanceTreeState=?
      ::updateLog
      ::useCIDTable=?
      ::topLevelUpdate=false
      (renderedElement, reactElement, nextReactElement) => {
    /*
     * Identity Policy for reactElement.
     * Nested elements determine shape: if the shape is not identical, re-render.
     * Flat elements use a positional match by default, where components at
     * the same position (from left) are matched for updates.
     * If the component has an explicit cID, match the instance with the same cID.
     * Note: components are matched for ID across the entire reactElement structure.
     */
    let processElement ::idTable ::posTable position element :instanceTree =>
      switch element {
      | Element component when component.cID !== noCID =>
        switch (InstanceTreeHash.lookupCID idTable component.cID) {
        | Some subInstanceTree =>
          /* instance tree with the same component id */
          update ::?updateInstanceTreeState ::updateLog subInstanceTree element
        | None =>
          /* not found: render a new instance */
          renderElement element
        }
      | Element _ =>
        switch (InstanceTreeHash.lookupPosition posTable position) {
        | Some subInstanceTree =>
          /* instance tree at the corresponding position */
          update ::?updateInstanceTreeState ::updateLog subInstanceTree element
        | None =>
          /* not found: render a new instance */
          renderElement element
        }
      | String _ => renderElement element
      };
    switch (renderedElement, reactElement, nextReactElement) {
    | (
        INested iName instanceSubTrees,
        Nested _ reactElements,
        Nested _ [nextReactElement, ...nextReactElements]
      )
        when nextReactElements === reactElements && !GlobalState.useTailHack =>
      /* Detected that nextReactElement was obtained by adding one element  */
      INested iName [renderReactElement nextReactElement, ...instanceSubTrees]
    | (INested iName iL, Nested _ l, Nested _ nL)
        when List.length nL === List.length iL && List.length nL === List.length l =>
      let cIDTable =
        switch useCIDTable {
        | None => InstanceTreeHash.createCIDTable renderedElement
        | Some idTable => idTable
        };
      INested
        iName
        (
          ListTR.map3
            (updateRenderedElement ::?updateInstanceTreeState ::updateLog useCIDTable::cIDTable)
            iL
            l
            nL
        )
    | (IFlat _, Flat _, Flat _) =>
      let instanceTrees = flattenRenderedElement renderedElement;
      let idTable =
        switch useCIDTable {
        | None => InstanceTreeHash.createCIDTable (IFlat instanceTrees)
        | Some idTable =>
          /* TODO: keep ID table, build new pos table */
          idTable
        };
      let posTable = InstanceTreeHash.createPositionTable instanceTrees;
      IFlat (
        List.mapi (processElement ::idTable ::posTable) (flattenReactElement nextReactElement)
      )
    | _ =>
      let idTable =
        switch useCIDTable {
        | None => InstanceTreeHash.createCIDTable renderedElement
        | Some idTable => idTable
        };
      let newRenderedElement = renderReactElement useIdTable::idTable nextReactElement;
      if topLevelUpdate {
        UpdateLog.add updateLog (NewRenderedElement newRenderedElement)
      };
      newRenderedElement
    }
  };

  /**
   * Execute the pending updates at the top level of an instance tree.
   * If no state change is performed, the argument is returned unchanged.
   */
  let executePendingStateUpdates instanceTree => {
    let InstanceTree instance = instanceTree;
    let executeUpdate ::state stateUpdate =>
      switch (stateUpdate state) {
      | NoUpdate => state
      | Update newState => newState
      };
    let rec executeUpdates ::state stateUpdates =>
      switch stateUpdates {
      | [] => state
      | [stateUpdate, ...otherStateUpdates] =>
        let nextState = executeUpdate ::state stateUpdate;
        executeUpdates state::nextState otherStateUpdates
      };
    let pendingUpdates = List.rev !instance.pendingStateUpdates;
    instance.pendingStateUpdates := [];
    let nextState = executeUpdates state::instance.iState pendingUpdates;
    instance.iState === nextState ? instanceTree : InstanceTree {...instance, iState: nextState}
  };

  /**
   * Flush the pending updates in an instance tree.
   * TODO: invoke lifecycles
   */
  let flushPendingUpdates ::updateLog instanceTree => {
    let InstanceTree {element} = instanceTree;
    update ::updateLog updateInstanceTreeState::executePendingStateUpdates instanceTree element
  };
};

module RenderedElement = {

  /**
   * Rendering produces a list of instance trees.
   */
  type t = renderedElement;
  let listToRenderedElement renderedElements => INested "List" renderedElements;
  let render reactElement :t => Render.renderReactElement reactElement;
  let update (renderedElement: t) reactElement :(t, UpdateLog.t) => {
    let updateLog = UpdateLog.create ();
    let newRenderedElement =
      Render.updateRenderedElement
        topLevelUpdate::true ::updateLog (renderedElement, reactElement, reactElement);
    (newRenderedElement, updateLog)
  };

  /**
   * Flush the pending updates in an instance tree.
   * TODO: invoke lifecycles
   */
  let flushPendingUpdates (renderedElement: t) :(t, UpdateLog.t) => {
    let updateLog = UpdateLog.create ();
    let newRenderedElement =
      Render.mapRenderedElement (Render.flushPendingUpdates ::updateLog) renderedElement;
    (newRenderedElement, updateLog)
  };
};

let statelessComponent ::useCID=? debugName => {
  ...basicComponent ::?useCID debugName,
  initialState: fun () => ()
};

let statefulComponent ::useCID=? debugName => basicComponent ::?useCID debugName;

let reducerComponent ::useCID=? debugName => basicComponent ::?useCID debugName;

let element component => {
  let componentWithID = component.cID == noCID ? component : {...component, cID: createCID ()};
  Flat [Element componentWithID]
};

let arrayToElement (a: array reactElement) :reactElement => Nested "Array" (Array.to_list a);

let listToElement l => Nested "List" l;

let stringToElement s :reactElement => Flat [String s];

module ReactDOMRe = {
  type reactDOMProps;
  let createElement name props::_props=? (elementArray: array reactElement) :reactElement =>
    Nested name (Array.to_list elementArray);
};

module OutputTree = {
  type tree =
    | S string
    | N node
  and node = {
    mutable id: int,
    mutable name: string,
    mutable state: string,
    mutable sub: list tree
  };
  type forest = list tree;
  type t = forest;
  let rec fromInstanceTree (InstanceTree {component, element, iState, instanceSubTree, id}) :tree =>
    switch element {
    | String s => S s
    | Element _ =>
      let state = component.printState iState;
      let name = component.debugName;
      let subTreeInstances = Render.flattenRenderedElement instanceSubTree;
      let sub = ListTR.map fromInstanceTree subTreeInstances;
      N {id, name, state, sub}
    };
  let fromRenderedElement renderedElement =>
    ListTR.map fromInstanceTree (Render.flattenRenderedElement renderedElement);
  let applyUpdateLog updateLog forest => {
    open UpdateLog;
    let rec applyEntryTree t entry :option tree =>
      switch entry {
      | NewRenderedElement _ => assert false
      | UpdateInstance {
          oldId,
          newId,
          oldInstanceTree,
          newInstanceTree,
          componentChanged,
          stateChanged,
          subTreeChanged
        } =>
        switch t {
        | S _ => None
        | N n =>
          if (n.id === oldId) {
            if (oldId !== newId) {
              n.id = newId
            };
            let InstanceTree {component, iState, instanceSubTree} = newInstanceTree;
            if componentChanged {
              n.name = component.debugName
            };
            if stateChanged {
              n.state = component.printState iState
            };
            if subTreeChanged {
              let InstanceTree {instanceSubTree: oldInstanceSubTree} = oldInstanceTree;
              let sub =
                switch (instanceSubTree, oldInstanceSubTree) {
                | (
                    INested _ [nextRenderedElement, ...nextRenderedElements],
                    INested _ oldRenderedElements
                  )
                    when nextRenderedElements === oldRenderedElements =>
                  let headTrees = fromRenderedElement nextRenderedElement;
                  List.rev_append (List.rev headTrees) n.sub
                | _ =>
                  let subTreeInstances = Render.flattenRenderedElement instanceSubTree;
                  ListTR.map fromInstanceTree subTreeInstances
                };
              n.sub = sub
            };
            Some t
          } else {
            switch (applyEntryForest n.sub entry) {
            | None => None
            | Some newSub =>
              if (n.sub !== newSub) {
                n.sub = newSub
              };
              Some t
            }
          }
        }
      }
    and applyEntryForest f entry :option forest =>
      switch f {
      | [] => None
      | [t, ...nextF] =>
        switch (applyEntryTree t entry) {
        | None =>
          switch (applyEntryForest nextF entry) {
          | None => None
          | Some newForest => Some [t, ...newForest]
          }
        | Some newT => Some [newT, ...nextF]
        }
      };
    let applyEntryForestToplevel f entry =>
      switch entry {
      | NewRenderedElement renderedElement => Some (fromRenderedElement renderedElement)
      | UpdateInstance _ => applyEntryForest f entry
      };
    List.fold_left
      (
        fun f entry =>
          switch (applyEntryForestToplevel f entry) {
          | None => f
          | Some newF => newF
          }
      )
      forest
      !updateLog
  };
  let arrayStr lst => String.concat "," lst;
  let printTree tree => {
    let rec pp ::indent =>
      fun
      | N {id, name, state, sub} => {
          let nextIndent = "  " ^ indent;
          Printf.sprintf
            "\n%s{%s\n%sid:%d\n%s\"%s.subtree\": %s\n%s}"
            indent
            (state == "" ? "" : Printf.sprintf "\n%s\"%s.state\": %s," nextIndent name state)
            nextIndent
            id
            nextIndent
            name
            (ListTR.map (pp indent::nextIndent) sub |> arrayStr)
            indent
        }
      | S s => s;
    ();
    pp indent::"" tree
  };
  let print (treeList: forest) => {
    let arrayStr lst => String.concat "," lst;
    let l: list string =
      List.mapi
        (fun i tree => "Tree #" ^ string_of_int i ^ " " ^ arrayStr [printTree tree]) treeList;
    String.concat "\n" l
  };
};

module RunAction = {
  type t 'action = {mutable runAction: 'action => unit};
  let runActionDefault _action => ();
  let create () => {runAction: runActionDefault};
  let initialize ::reduce x =>
    if (x.runAction === runActionDefault) {
      x.runAction = (fun action => reduce (fun _e => action) ())
    };
  let run x ::action => x.runAction action;
};