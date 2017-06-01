type reactClass = ReasonReact.reactClass;

type reactElement = ReasonReact.reactElement;

type reactRef = ReasonReact.reactRef;

type reactJsChildren;

external createElement : reactClass => props::Js.t {..}? => array reactElement => reactElement =
  "createElement" [@@bs.splice] [@@bs.val] [@@bs.module "react"];

external nullElement : reactElement = "null" [@@bs.val];

external stringToElement : string => reactElement = "%identity";

external arrayToElement : array reactElement => reactElement = "%identity";

let listToElement : list reactElement => reactElement;

external refToJsObj : reactRef => Js.t {..} = "%identity";

let jsChildrenToReason: Js.null_undefined reactJsChildren => list reactElement;

module ComponentBase: {
  type componentBag 'state 'props 'instanceVars = {
    state: 'state,
    props: 'props,
    updater:
      'dataPassedToHandler .
      (componentBag 'state 'props 'instanceVars => 'dataPassedToHandler => option 'state) =>
      'dataPassedToHandler =>
      unit,

    handler: 'dataPassedToHandler . (componentBag 'state 'props 'instanceVars => 'dataPassedToHandler => unit) => 'dataPassedToHandler => unit,
    instanceVars: 'instanceVars,
    setState: (componentBag 'state 'props 'instanceVars => 'state) => unit
  };
};

module type CompleteComponentSpec = {
  let name: string;
  type props;
  type state;
  type instanceVars;
  type jsProps;
  let getInstanceVars: unit => instanceVars;
  let getInitialState: props => state;
  let componentDidMount: ComponentBase.componentBag state props instanceVars => option state;
  let componentWillReceiveProps:
    ComponentBase.componentBag state props instanceVars => nextProps::props => option state;
  let componentWillUpdate:
    ComponentBase.componentBag state props instanceVars =>
    nextProps::props =>
    nextState::state =>
    option state;
  let componentDidUpdate:
    prevProps::props =>
    prevState::state =>
    ComponentBase.componentBag state props instanceVars =>
    option state;
  let componentWillUnmount: ComponentBase.componentBag state props instanceVars => unit;
  let jsPropsToReasonProps: option (jsProps => props);
  let render: ComponentBase.componentBag state props instanceVars => reactElement;
};

module CreateComponent:
  (CompleteComponentSpec: CompleteComponentSpec) =>
  {
    let comp: reactClass;
    let wrapProps:
      CompleteComponentSpec.props =>
      children::list reactElement =>
      ref::(reactRef => unit)? =>
      key::string? =>
      unit =>
      reactElement;
  };

let wrapPropsShamelessly:
  reactClass =>
  Js.t {..} =>
  children::list reactElement =>
  ref::(reactRef => unit)? =>
  key::string? =>
  unit =>
  reactElement;

/* Don't be scared off by this signature's size! Notice that you will only ever use one of the modules or
submodule in a component. */
module Component: {
  type componentBag 'state 'props 'instanceVars =
    ComponentBase.componentBag 'state 'props 'instanceVars =
      {
        state: 'state,
        props: 'props,
        updater:
          'dataPassedToHandler .
          (componentBag 'state 'props 'instanceVars => 'dataPassedToHandler => option 'state) =>
          'dataPassedToHandler =>
          unit,

        handler:
          'dataPassedToHandler .
          (componentBag 'state 'props 'instanceVars => 'dataPassedToHandler => unit) => 'dataPassedToHandler => unit,
        instanceVars: 'instanceVars,
        setState: (componentBag 'state 'props 'instanceVars => 'state) => unit
      };
  let componentDidMount: 'a => option 'b;
  let componentWillUpdate: 'a => nextProps::'b => nextState::'c => option 'd;
  let componentDidUpdate: prevProps::'a => prevState::'b => 'c => option 'd;
  let componentWillReceiveProps: 'a => nextProps::'b => option 'c;
  let componentWillUnmount: 'a => unit;
  type jsProps = unit;
  type instanceVars = unit;
  type state = unit;
  let getInstanceVars: unit => unit;
  let jsPropsToReasonProps: option 'a;
  let getInitialState: 'a => unit;
  module Stateful: {
    type componentBag 'state 'props 'instanceVars =
      ComponentBase.componentBag 'state 'props 'instanceVars =
        {
          state: 'state,
          props: 'props,
          updater:
            'dataPassedToHandler .
            (componentBag 'state 'props 'instanceVars => 'dataPassedToHandler => option 'state) =>
            'dataPassedToHandler =>
            unit,

          handler:
            'dataPassedToHandler .
            (componentBag 'state 'props 'instanceVars => 'dataPassedToHandler => unit) => 'dataPassedToHandler => unit,
          instanceVars: 'instanceVars,
          setState: (componentBag 'state 'props 'instanceVars => 'state) => unit
        };
    let componentDidMount: 'a => option 'b;
    let componentWillUpdate: 'a => nextProps::'b => nextState::'c => option 'd;
    let componentDidUpdate: prevProps::'a => prevState::'b => 'c => option 'd;
    let componentWillReceiveProps: 'a => nextProps::'b => option 'c;
    let componentWillUnmount: 'a => unit;
    type jsProps = unit;
    type instanceVars = unit;
    let getInstanceVars: unit => unit;
    let jsPropsToReasonProps: option 'a;
    module JsProps: {
      type componentBag 'state 'props 'instanceVars =
        ComponentBase.componentBag 'state 'props 'instanceVars =
          {
            state: 'state,
            props: 'props,
            updater:
              'dataPassedToHandler .
              (
                componentBag 'state 'props 'instanceVars => 'dataPassedToHandler => option 'state
              ) =>
              'dataPassedToHandler =>
              unit,

            handler:
              'dataPassedToHandler .
              (componentBag 'state 'props 'instanceVars => 'dataPassedToHandler => unit) => 'dataPassedToHandler => unit,
            instanceVars: 'instanceVars,
            setState: (componentBag 'state 'props 'instanceVars => 'state) => unit
          };
      let componentDidMount: 'a => option 'b;
      let componentWillUpdate: 'a => nextProps::'b => nextState::'c => option 'd;
      let componentDidUpdate: prevProps::'a => prevState::'b => 'c => option 'd;
      let componentWillReceiveProps: 'a => nextProps::'b => option 'c;
      let componentWillUnmount: 'a => unit;
      type instanceVars = unit;
      let getInstanceVars: unit => unit;
      let jsPropsToReasonProps: option 'a;
    };
    module InstanceVars: {
      type componentBag 'state 'props 'instanceVars =
        ComponentBase.componentBag 'state 'props 'instanceVars =
          {
            state: 'state,
            props: 'props,
            updater:
              'dataPassedToHandler .
              (
                componentBag 'state 'props 'instanceVars => 'dataPassedToHandler => option 'state
              ) =>
              'dataPassedToHandler =>
              unit,

            handler:
              'dataPassedToHandler .
              (componentBag 'state 'props 'instanceVars => 'dataPassedToHandler => unit) => 'dataPassedToHandler => unit,
            instanceVars: 'instanceVars,
            setState: (componentBag 'state 'props 'instanceVars => 'state) => unit
          };
      let componentDidMount: 'a => option 'b;
      let componentWillUpdate: 'a => nextProps::'b => nextState::'c => option 'd;
      let componentDidUpdate: prevProps::'a => prevState::'b => 'c => option 'd;
      let componentWillReceiveProps: 'a => nextProps::'b => option 'c;
      let componentWillUnmount: 'a => unit;
      type jsProps = unit;
      let jsPropsToReasonProps: option 'a;
      module JsProps: {
        type componentBag 'state 'props 'instanceVars =
          ComponentBase.componentBag 'state 'props 'instanceVars =
            {
              state: 'state,
              props: 'props,
              updater:
                'dataPassedToHandler .
                (
                  componentBag 'state 'props 'instanceVars => 'dataPassedToHandler => option 'state
                ) =>
                'dataPassedToHandler =>
                unit,

              handler:
                'dataPassedToHandler .
                (componentBag 'state 'props 'instanceVars => 'dataPassedToHandler => unit) => 'dataPassedToHandler => unit,
              instanceVars: 'instanceVars,
              setState: (componentBag 'state 'props 'instanceVars => 'state) => unit
            };
        let componentDidMount: 'a => option 'b;
        let componentWillUpdate: 'a => nextProps::'b => nextState::'c => option 'd;
        let componentDidUpdate: prevProps::'a => prevState::'b => 'c => option 'd;
        let componentWillReceiveProps: 'a => nextProps::'b => option 'c;
        let componentWillUnmount: 'a => unit;
      };
    };
  };
  module JsProps: {
    type componentBag 'state 'props 'instanceVars =
      ComponentBase.componentBag 'state 'props 'instanceVars =
        {
          state: 'state,
          props: 'props,
          updater:
            'dataPassedToHandler .
            (componentBag 'state 'props 'instanceVars => 'dataPassedToHandler => option 'state) =>
            'dataPassedToHandler =>
            unit,

          handler:
            'dataPassedToHandler .
            (componentBag 'state 'props 'instanceVars => 'dataPassedToHandler => unit) => 'dataPassedToHandler => unit,
          instanceVars: 'instanceVars,
          setState: (componentBag 'state 'props 'instanceVars => 'state) => unit
        };
    let componentDidMount: 'a => option 'b;
    let componentWillUpdate: 'a => nextProps::'b => nextState::'c => option 'd;
    let componentDidUpdate: prevProps::'a => prevState::'b => 'c => option 'd;
    let componentWillReceiveProps: 'a => nextProps::'b => option 'c;
    let componentWillUnmount: 'a => unit;
    type instanceVars = unit;
    type state = unit;
    let getInstanceVars: unit => unit;
    let getInitialState: 'a => unit;
  };
  module InstanceVars: {
    type componentBag 'state 'props 'instanceVars =
      ComponentBase.componentBag 'state 'props 'instanceVars =
        {
          state: 'state,
          props: 'props,
          updater:
            'dataPassedToHandler .
            (componentBag 'state 'props 'instanceVars => 'dataPassedToHandler => option 'state) =>
            'dataPassedToHandler =>
            unit,

          handler:
            'dataPassedToHandler .
            (componentBag 'state 'props 'instanceVars => 'dataPassedToHandler => unit) => 'dataPassedToHandler => unit,
          instanceVars: 'instanceVars,
          setState: (componentBag 'state 'props 'instanceVars => 'state) => unit
        };
    let componentDidMount: 'a => option 'b;
    let componentWillUpdate: 'a => nextProps::'b => nextState::'c => option 'd;
    let componentDidUpdate: prevProps::'a => prevState::'b => 'c => option 'd;
    let componentWillReceiveProps: 'a => nextProps::'b => option 'c;
    let componentWillUnmount: 'a => unit;
    type jsProps = unit;
    type state = unit;
    let getInitialState: 'a => unit;
    let jsPropsToReasonProps: option 'a;
    module JsProps: {
      type componentBag 'state 'props 'instanceVars =
        ComponentBase.componentBag 'state 'props 'instanceVars =
          {
            state: 'state,
            props: 'props,
            updater:
              'dataPassedToHandler .
              (
                componentBag 'state 'props 'instanceVars => 'dataPassedToHandler => option 'state
              ) =>
              'dataPassedToHandler =>
              unit,

            handler:
              'dataPassedToHandler .
              (componentBag 'state 'props 'instanceVars => 'dataPassedToHandler => unit) => 'dataPassedToHandler => unit,
            instanceVars: 'instanceVars,
            setState: (componentBag 'state 'props 'instanceVars => 'state) => unit
          };
      let componentDidMount: 'a => option 'b;
      let componentWillUpdate: 'a => nextProps::'b => nextState::'c => option 'd;
      let componentDidUpdate: prevProps::'a => prevState::'b => 'c => option 'd;
      let componentWillReceiveProps: 'a => nextProps::'b => option 'c;
      let componentWillUnmount: 'a => unit;
      type state = unit;
      let getInitialState: 'a => unit;
    };
  };
};
