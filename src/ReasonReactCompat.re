open ReasonReact;

type sideEffectualState('state, 'retainedProps, 'action) = {
  sideEffects: array(self('state, 'retainedProps, 'action) => unit),
  state: 'state,
};

/*
 let make = (~foo, ~bar, _) => {
   ...component,
   render: (_) => <div/>
 };

 [@react.component]
 let make = (~foo, ~bar, _) => ReasonReact.useRecordApi({
   ...component,
   render: _ => <div />
 });
 */
let useRecordApi = componentSpec => {
  open React.Ref;

  let initialState = React.useMemo0(componentSpec.initialState);
  let unmountSideEffects = React.useRef([||]);
  let ({sideEffects, state}, send) =
    React.useReducer(
      (fullState, action) => {
        let recordApiStateReturn =
          componentSpec.reducer(action, fullState.state);
        switch (recordApiStateReturn) {
        | NoUpdate => fullState /* useReducer returns of the same value will not rerender the component */
        | Update(state) => {sideEffects: [||], state}
        | SideEffects(sideEffect) => {
            ...fullState,
            sideEffects:
              Js.Array.concat(fullState.sideEffects, [|sideEffect|]),
          }
        | UpdateWithSideEffects(state, sideEffect) => {
            sideEffects:
              Js.Array.concat(fullState.sideEffects, [|sideEffect|]),
            state,
          }
        };
      },
      {sideEffects: [||], state: initialState},
    );

  let rec self = {
    handle: (fn, payload) => fn(payload, self),
    retainedProps: componentSpec.retainedProps,
    send,
    state,
    onUnmount: sideEffect =>
      Js.Array.push(sideEffect, unmountSideEffects->current)->ignore,
  };

  let state = componentSpec.willReceiveProps(self);

  let rec self = {
    handle: (fn, payload) => fn(payload, self),
    retainedProps: componentSpec.retainedProps,
    send,
    state,
    onUnmount: sideEffect =>
      Js.Array.push(sideEffect, unmountSideEffects->current)->ignore,
  };

  let oldSelf = React.useRef(self);

  let hasBeenCalled = React.useRef(false);

  let _mountUnmountEffect =
    React.useLayoutEffect0(() => {
      componentSpec.didMount(self);
      Some(
        () => {
          Js.Array.forEach(fn => fn(), unmountSideEffects->current);
          /* shouldn't be needed but like - better safe than sorry? */
          unmountSideEffects->setCurrent([||]);
          componentSpec.willUnmount(self);
        },
      );
    });
  let _didUpdateEffect =
    React.useLayoutEffect(() => {
      if (!hasBeenCalled->current) {
        componentSpec.didUpdate({oldSelf: oldSelf->current, newSelf: self});
      } else {
        hasBeenCalled->setCurrent(true);
      };
      Js.Array.forEach(fn => fn(self), sideEffects);

      oldSelf->setCurrent(self);
      None;
    });

  let mostRecentAllowedRender =
    React.useRef(React.useMemo0(() => componentSpec.render(self)));

  if (hasBeenCalled->current
      && oldSelf->current.state !== self.state
      && componentSpec.shouldUpdate({
           oldSelf: oldSelf->current,
           newSelf: self,
         })) {
    componentSpec.willUpdate({oldSelf: oldSelf->current, newSelf: self});
    mostRecentAllowedRender->setCurrent(componentSpec.render(self));
  };
  mostRecentAllowedRender->current;
};
