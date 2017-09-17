type sideEffects = unit => unit;

type stateless = unit;

type updaterCallback 'state 'event = 'state => 'event => 'state
and boundUpdater 'state 'event = instance 'state => 'event => (instance 'state, list sideEffects)
and update 'state 'event = updaterCallback 'state 'event => boundUpdater 'state 'event
and self 'state = {
  state: 'state,
  update: 'event .update 'state 'event
}
/**
 * Elements are what JSX blocks become. They represent the *potential* for a
 * component instance and state to be created / updated. They are not yet
 * instances.
 */
and element =
  | Element (component 'state) :element
/**
 * We will want to replace this with a more efficient data structure.
 */
and reactElement = list element
and component 'state = {
  debugName: string,
  didMount: self 'state => list sideEffects,
  didUnmount: self 'state => list sideEffects,
  handedOffState: ref (option 'state),
  hitTest: self 'state => bool,
  initialState: unit => 'state,
  printState: 'state => string,
  willReceiveProps: self 'state => 'state,
  render: self 'state => reactElement
}
/**
 * Elements turn into instances at the right time. These instances record the
 * most recent state among other things.
 */
and instance 'state = {
  component: component 'state,
  /**
   * This may not be a good idea to hold onto for sake of memory, but it makes
   * it convenient to implement shouldComponentUpdate.
   */
  element,
  iState: 'state,
  iPrintState: 'state => string,
  /**
   * Most recent subtree of instances.
   */
  subtree: list instanceTree
}
/**
 * The result of "rendering" an Element, is a tree of instances that are
 * produced. This tree is then updated to produce a new *version* of the
 * instance tree based on the old - the old one is not mutated.
 */
and instanceTree =
  | InstanceTree (instance 'state) :instanceTree;

let debug = true;

let logString txt =>
  debug ?
    {
      print_string txt;
      print_newline ()
    } :
    ();

module Render = {
  let selfUnsafe = ref (lazy (assert false));
  /* unsafe mode: create the update function only once and re-use it with Obj.magic */
  let unsafe = false;
  let createSelf_ ::state ::update :self _ => {
    let noMutations = [];
    let rec self = {
      state,
      update: fun callback ({component, iState, subtree} as instance) event => {
        let nextState = callback iState event;
        let nextSubelements = component.render {...self, state: nextState};
        let nextSubtree = List.map2 update subtree nextSubelements;
        ({...instance, iState: nextState, subtree: nextSubtree}, noMutations)
      }
    };
    self
  };
  let initSelfUnsafe ::update =>
    if unsafe {
      selfUnsafe := (lazy (createSelf_ state::(Obj.magic ()) ::update))
    };
  let createSelf ::state ::update =>
    unsafe ? {...Obj.magic (Lazy.force !selfUnsafe), state} : createSelf_ ::state ::update;

  /**
   * Initial render of an Element. Recurses to produce the entire tree of
   * instances.
   */
  let renderFunction ::update element :instanceTree => {
    let rec render (Element component as element) => {
      let state = component.initialState ();
      let self = createSelf ::state ::update;
      let subelements = component.render self;
      logString (
        "Creating "
        ^ component.debugName
        ^ " With Subelements:"
        ^ string_of_int (List.length subelements)
      );
      let subtree = List.map render subelements;
      InstanceTree {component, element, iState: state, iPrintState: component.printState, subtree}
    };
    render element
  };

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
  let rec update
          (InstanceTree {component, element, iState, subtree} as tree)
          (Element nextComponent as nextElement)
          :instanceTree =>
    if (element === nextElement) {
      logString ("Bailing Out Early Due To Memoization on Component type " ^ component.debugName);
      tree
    } else {
      component.handedOffState := Some iState;
      switch !nextComponent.handedOffState {
      /*
       * Case A: The next element *is* of the same component class.
       */
      | Some nextComponentState =>
        /* DO NOT FORGET TO RESET HANDEDOFFSTATE */
        component.handedOffState := None;
        logString ("Updating Component type " ^ nextComponent.debugName);
        let self = createSelf state::nextComponentState ::update;
        let nextState = nextComponent.willReceiveProps self;
        let nextSubelements = nextComponent.render self;
        /* TODO: Invoke any lifecycles necessary. */
        let nextSubtree = List.map2 update subtree nextSubelements;
        InstanceTree {
          component: nextComponent,
          element: nextElement,
          iState: nextState,
          iPrintState: nextComponent.printState,
          subtree: nextSubtree
        }
      /*
       * Case B: The next element is *not* of the same component class. We know
       * because otherwise we would have observed the mutation on
       * `nextComponentClass`.
       */
      | None =>
        /* DO NOT FORGET TO RESET HANDEDOFFSTATE */
        component.handedOffState := None;
        let nextState = nextComponent.initialState ();
        let self = createSelf state::nextState ::update;
        let nextSubelements = nextComponent.render self;
        logString (
          "Switching Component Types from: "
          ^ component.debugName
          ^ " to "
          ^ nextComponent.debugName
        );
        /* TODO: Invoke destruction lifecycle on previous component. */
        /* TODO: Invoke creation lifecycle on next component. */
        let nextSubtree = List.map (renderFunction ::update) nextSubelements;
        InstanceTree {
          component: nextComponent,
          element: nextElement,
          iState: nextState,
          iPrintState: nextComponent.printState,
          subtree: nextSubtree
        }
      }
    };
  initSelfUnsafe ::update;
};

let render reactElement => List.map Render.(renderFunction ::update) reactElement;

let update instanceTrees reactElement =>
  List.length instanceTrees == List.length reactElement ?
    List.map2 Render.update instanceTrees reactElement : render reactElement;

let defaultComponent debugName :component 'a => {
  debugName,
  didMount: fun _self => [],
  didUnmount: fun _self => [],
  handedOffState: ref None,
  hitTest: fun _self => false,
  initialState: fun () => assert false,
  printState: fun _state => "",
  willReceiveProps: fun {state} => state,
  render: fun _self => assert false
};

let createComponent debugName => defaultComponent debugName;

let createStatelessComponent debugName => {
  ...defaultComponent debugName,
  initialState: fun () => ()
};

let element component => [Element component];

module ReactDOMRe = {
  type reactDOMProps;
  let createElement _name props::_props=? elementArray =>
    List.flatten (Array.to_list elementArray);
};

module Print = {
  let arrayStr lst => String.concat "," lst;

  /** Print a tree */
  let tree instanceTree => {
    let rec print ::indent (InstanceTree {component, iState, subtree}) => {
      let s = component.printState iState;
      let nextIndent = "  " ^ indent;
      Printf.sprintf
        "\n%s{%s\n%s\"%s.subtree\": %s\n%s}"
        indent
        (s == "" ? "" : Printf.sprintf "\n%s\"%s.state\": %s," nextIndent component.debugName s)
        nextIndent
        component.debugName
        (arrayStr (List.map (print indent::nextIndent) subtree))
        indent
    };
    print indent::"" instanceTree
  };
  let trees treeList => {
    let l: list string =
      List.mapi (fun i t => "Tree #" ^ string_of_int i ^ arrayStr [tree t]) treeList;
    String.concat "\n" l
  };
};

let arrayToElement (a: array reactElement) :reactElement => Array.to_list a |> List.flatten;