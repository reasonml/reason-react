let _assign = Js.Obj.assign;

let emptyObject = Js.Obj.empty();

%bs.raw
{|
/**
 * Copyright 2013-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 *
 */

// 'use strict';

// var _assign = require('object-assign');

// var emptyObject = require('emptyObject');
// var _invariant = require('invariant');

// if (process.env.NODE_ENV !== 'production') {
//   var warning = require('fbjs/lib/warning');
// }

var MIXINS_KEY = 'mixins';

// Helper function to allow the creation of anonymous functions which do not
// have .name set to the name of the variable being assigned to.
function identity(fn) {
  return fn;
}

var ReactPropTypeLocationNames;
// if (process.env.NODE_ENV !== 'production') {
//   ReactPropTypeLocationNames = {
//     prop: 'prop',
//     context: 'context',
//     childContext: 'child context'
//   };
// } else {
  ReactPropTypeLocationNames = {};
// }
|};

let factory = [%bs.raw
  {|
function factory(ReactComponent, isValidElement, ReactNoopUpdateQueue) {
  /**
   * Policies that describe methods in `ReactClassInterface`.
   */

  var injectedMixins = [];

  /**
   * Composite components are higher-level components that compose other composite
   * or host components.
   *
   * To create a new type of `ReactClass`, pass a specification of
   * your new class to `React.createClass`. The only requirement of your class
   * specification is that you implement a `render` method.
   *
   *   var MyComponent = React.createClass({
   *     render: function() {
   *       return <div>Hello World</div>;
   *     }
   *   });
   *
   * The class specification supports a specific protocol of methods that have
   * special meaning (e.g. `render`). See `ReactClassInterface` for
   * more the comprehensive protocol. Any other properties and methods in the
   * class specification will be available on the prototype.
   *
   * @interface ReactClassInterface
   * @internal
   */
  var ReactClassInterface = {
    /**
     * An array of Mixin objects to include when defining your component.
     *
     * @type {array}
     * @optional
     */
    mixins: 'DEFINE_MANY',

    /**
     * An object containing properties and methods that should be defined on
     * the component's constructor instead of its prototype (static methods).
     *
     * @type {object}
     * @optional
     */
    statics: 'DEFINE_MANY',

    /**
     * Definition of prop types for this component.
     *
     * @type {object}
     * @optional
     */
    propTypes: 'DEFINE_MANY',

    /**
     * Definition of context types for this component.
     *
     * @type {object}
     * @optional
     */
    contextTypes: 'DEFINE_MANY',

    /**
     * Definition of context types this component sets for its children.
     *
     * @type {object}
     * @optional
     */
    childContextTypes: 'DEFINE_MANY',

    // ==== Definition methods ====

    /**
     * Invoked when the component is mounted. Values in the mapping will be set on
     * `this.props` if that prop is not specified (i.e. using an `in` check).
     *
     * This method is invoked before `getInitialState` and therefore cannot rely
     * on `this.state` or use `this.setState`.
     *
     * @return {object}
     * @optional
     */
    getDefaultProps: 'DEFINE_MANY_MERGED',

    /**
     * Invoked once before the component is mounted. The return value will be used
     * as the initial value of `this.state`.
     *
     *   getInitialState: function() {
     *     return {
     *       isOn: false,
     *       fooBaz: new BazFoo()
     *     }
     *   }
     *
     * @return {object}
     * @optional
     */
    getInitialState: 'DEFINE_MANY_MERGED',

    /**
     * @return {object}
     * @optional
     */
    getChildContext: 'DEFINE_MANY_MERGED',

    /**
     * Uses props from `this.props` and state from `this.state` to render the
     * structure of the component.
     *
     * No guarantees are made about when or how often this method is invoked, so
     * it must not have side effects.
     *
     *   render: function() {
     *     var name = this.props.name;
     *     return <div>Hello, {name}!</div>;
     *   }
     *
     * @return {ReactComponent}
     * @required
     */
    render: 'DEFINE_ONCE',

    // ==== Delegate methods ====

    /**
     * Invoked when the component is initially created and about to be mounted.
     * This may have side effects, but any external subscriptions or data created
     * by this method must be cleaned up in `componentWillUnmount`.
     *
     * @optional
     */
    componentWillMount: 'DEFINE_MANY',

    /**
     * Invoked when the component has been mounted and has a DOM representation.
     * However, there is no guarantee that the DOM node is in the document.
     *
     * Use this as an opportunity to operate on the DOM when the component has
     * been mounted (initialized and rendered) for the first time.
     *
     * @param {DOMElement} rootNode DOM element representing the component.
     * @optional
     */
    componentDidMount: 'DEFINE_MANY',

    /**
     * Invoked before the component receives new props.
     *
     * Use this as an opportunity to react to a prop transition by updating the
     * state using `this.setState`. Current props are accessed via `this.props`.
     *
     *   componentWillReceiveProps: function(nextProps, nextContext) {
     *     this.setState({
     *       likesIncreasing: nextProps.likeCount > this.props.likeCount
     *     });
     *   }
     *
     * NOTE: There is no equivalent `componentWillReceiveState`. An incoming prop
     * transition may cause a state change, but the opposite is not true. If you
     * need it, you are probably looking for `componentWillUpdate`.
     *
     * @param {object} nextProps
     * @optional
     */
    componentWillReceiveProps: 'DEFINE_MANY',

    /**
     * Invoked while deciding if the component should be updated as a result of
     * receiving new props, state and/or context.
     *
     * Use this as an opportunity to `return false` when you're certain that the
     * transition to the new props/state/context will not require a component
     * update.
     *
     *   shouldComponentUpdate: function(nextProps, nextState, nextContext) {
     *     return !equal(nextProps, this.props) ||
     *       !equal(nextState, this.state) ||
     *       !equal(nextContext, this.context);
     *   }
     *
     * @param {object} nextProps
     * @param {?object} nextState
     * @param {?object} nextContext
     * @return {boolean} True if the component should update.
     * @optional
     */
    shouldComponentUpdate: 'DEFINE_ONCE',

    /**
     * Invoked when the component is about to update due to a transition from
     * `this.props`, `this.state` and `this.context` to `nextProps`, `nextState`
     * and `nextContext`.
     *
     * Use this as an opportunity to perform preparation before an update occurs.
     *
     * NOTE: You **cannot** use `this.setState()` in this method.
     *
     * @param {object} nextProps
     * @param {?object} nextState
     * @param {?object} nextContext
     * @param {ReactReconcileTransaction} transaction
     * @optional
     */
    componentWillUpdate: 'DEFINE_MANY',

    /**
     * Invoked when the component's DOM representation has been updated.
     *
     * Use this as an opportunity to operate on the DOM when the component has
     * been updated.
     *
     * @param {object} prevProps
     * @param {?object} prevState
     * @param {?object} prevContext
     * @param {DOMElement} rootNode DOM element representing the component.
     * @optional
     */
    componentDidUpdate: 'DEFINE_MANY',

    /**
     * Invoked when the component is about to be removed from its parent and have
     * its DOM representation destroyed.
     *
     * Use this as an opportunity to deallocate any external resources.
     *
     * NOTE: There is no `componentDidUnmount` since your component will have been
     * destroyed by that point.
     *
     * @optional
     */
    componentWillUnmount: 'DEFINE_MANY',

    // ==== Advanced methods ====

    /**
     * Updates the component's currently mounted DOM representation.
     *
     * By default, this implements React's rendering and reconciliation algorithm.
     * Sophisticated clients may wish to override this.
     *
     * @param {ReactReconcileTransaction} transaction
     * @internal
     * @overridable
     */
    updateComponent: 'OVERRIDE_BASE'
  };

  /**
   * Mapping from class specification keys to special processing functions.
   *
   * Although these are declared like instance properties in the specification
   * when defining classes using `React.createClass`, they are actually static
   * and are accessible on the constructor instead of the prototype. Despite
   * being static, they must be defined outside of the "statics" key under
   * which all other static methods are defined.
   */
  var RESERVED_SPEC_KEYS = {
    displayName: function(Constructor, displayName) {
      Constructor.displayName = displayName;
    },
    mixins: function(Constructor, mixins) {
      if (mixins) {
        for (var i = 0; i < mixins.length; i++) {
          mixSpecIntoComponent(Constructor, mixins[i]);
        }
      }
    },
    childContextTypes: function(Constructor, childContextTypes) {
      // if (process.env.NODE_ENV !== 'production') {
      //   validateTypeDef(Constructor, childContextTypes, 'childContext');
      // }
      Constructor.childContextTypes = _assign(
        {},
        Constructor.childContextTypes,
        childContextTypes
      );
    },
    contextTypes: function(Constructor, contextTypes) {
      // if (process.env.NODE_ENV !== 'production') {
      //   validateTypeDef(Constructor, contextTypes, 'context');
      // }
      Constructor.contextTypes = _assign(
        {},
        Constructor.contextTypes,
        contextTypes
      );
    },
    /**
     * Special case getDefaultProps which should move into statics but requires
     * automatic merging.
     */
    getDefaultProps: function(Constructor, getDefaultProps) {
      if (Constructor.getDefaultProps) {
        Constructor.getDefaultProps = createMergedResultFunction(
          Constructor.getDefaultProps,
          getDefaultProps
        );
      } else {
        Constructor.getDefaultProps = getDefaultProps;
      }
    },
    propTypes: function(Constructor, propTypes) {
      // if (process.env.NODE_ENV !== 'production') {
      //   validateTypeDef(Constructor, propTypes, 'prop');
      // }
      Constructor.propTypes = _assign({}, Constructor.propTypes, propTypes);
    },
    statics: function(Constructor, statics) {
      mixStaticSpecIntoComponent(Constructor, statics);
    },
    autobind: function() {}
  };

  function validateTypeDef(Constructor, typeDef, location) {
    for (var propName in typeDef) {
      // if (typeDef.hasOwnProperty(propName)) {
      //   // use a warning instead of an _invariant so components
      //   // don't show up in prod but only in __DEV__
      //   // if (process.env.NODE_ENV !== 'production') {
      //   //   warning(
      //   //     typeof typeDef[propName] === 'function',
      //   //     '%s: %s type `%s` is invalid; it must be a function, usually from ' +
      //   //       'React.PropTypes.',
      //   //     Constructor.displayName || 'ReactClass',
      //   //     ReactPropTypeLocationNames[location],
      //   //     propName
      //   //   );
      //   // }
      // }
    }
  }

  function validateMethodOverride(isAlreadyDefined, name) {
    var specPolicy = ReactClassInterface.hasOwnProperty(name)
      ? ReactClassInterface[name]
      : null;

    // Disallow overriding of base class methods unless explicitly allowed.
    if (ReactClassMixin.hasOwnProperty(name)) {
      // _invariant(
      //   specPolicy === 'OVERRIDE_BASE',
      //   'ReactClassInterface: You are attempting to override ' +
      //     '`%s` from your class specification. Ensure that your method names ' +
      //     'do not overlap with React methods.',
      //   name
      // );
    }

    // Disallow defining methods more than once unless explicitly allowed.
    if (isAlreadyDefined) {
      // _invariant(
      //   specPolicy === 'DEFINE_MANY' || specPolicy === 'DEFINE_MANY_MERGED',
      //   'ReactClassInterface: You are attempting to define ' +
      //     '`%s` on your component more than once. This conflict may be due ' +
      //     'to a mixin.',
      //   name
      // );
    }
  }

  /**
   * Mixin helper which handles policy validation and reserved
   * specification keys when building React classes.
   */
  function mixSpecIntoComponent(Constructor, spec) {
    if (!spec) {
      // if (process.env.NODE_ENV !== 'production') {
      //   var typeofSpec = typeof spec;
      //   var isMixinValid = typeofSpec === 'object' && spec !== null;
      //
      //   if (process.env.NODE_ENV !== 'production') {
      //     warning(
      //       isMixinValid,
      //       "%s: You're attempting to include a mixin that is either null " +
      //         'or not an object. Check the mixins included by the component, ' +
      //         'as well as any mixins they include themselves. ' +
      //         'Expected object but got %s.',
      //       Constructor.displayName || 'ReactClass',
      //       spec === null ? null : typeofSpec
      //     );
      //   }
      // }

      return;
    }

    // _invariant(
    //   typeof spec !== 'function',
    //   "ReactClass: You're attempting to " +
    //     'use a component class or function as a mixin. Instead, just use a ' +
    //     'regular object.'
    // );
    // _invariant(
    //   !isValidElement(spec),
    //   "ReactClass: You're attempting to " +
    //     'use a component as a mixin. Instead, just use a regular object.'
    // );

    var proto = Constructor.prototype;
    var autoBindPairs = proto.__reactAutoBindPairs;

    // By handling mixins before any other properties, we ensure the same
    // chaining order is applied to methods with DEFINE_MANY policy, whether
    // mixins are listed before or after these methods in the spec.
    if (spec.hasOwnProperty(MIXINS_KEY)) {
      RESERVED_SPEC_KEYS.mixins(Constructor, spec.mixins);
    }

    for (var name in spec) {
      if (!spec.hasOwnProperty(name)) {
        continue;
      }

      if (name === MIXINS_KEY) {
        // We have already handled mixins in a special case above.
        continue;
      }

      var property = spec[name];
      var isAlreadyDefined = proto.hasOwnProperty(name);
      validateMethodOverride(isAlreadyDefined, name);

      if (RESERVED_SPEC_KEYS.hasOwnProperty(name)) {
        RESERVED_SPEC_KEYS[name](Constructor, property);
      } else {
        // Setup methods on prototype:
        // The following member methods should not be automatically bound:
        // 1. Expected ReactClass methods (in the "interface").
        // 2. Overridden methods (that were mixed in).
        var isReactClassMethod = ReactClassInterface.hasOwnProperty(name);
        var isFunction = typeof property === 'function';
        var shouldAutoBind =
          isFunction &&
          !isReactClassMethod &&
          !isAlreadyDefined &&
          spec.autobind !== false;

        if (shouldAutoBind) {
          autoBindPairs.push(name, property);
          proto[name] = property;
        } else {
          if (isAlreadyDefined) {
            var specPolicy = ReactClassInterface[name];

            // These cases should already be caught by validateMethodOverride.
            // _invariant(
            //   isReactClassMethod &&
            //     (specPolicy === 'DEFINE_MANY_MERGED' ||
            //       specPolicy === 'DEFINE_MANY'),
            //   'ReactClass: Unexpected spec policy %s for key %s ' +
            //     'when mixing in component specs.',
            //   specPolicy,
            //   name
            // );

            // For methods which are defined more than once, call the existing
            // methods before calling the new property, merging if appropriate.
            if (specPolicy === 'DEFINE_MANY_MERGED') {
              proto[name] = createMergedResultFunction(proto[name], property);
            } else if (specPolicy === 'DEFINE_MANY') {
              proto[name] = createChainedFunction(proto[name], property);
            }
          } else {
            proto[name] = property;
            // if (process.env.NODE_ENV !== 'production') {
            //   // Add verbose displayName to the function, which helps when looking
            //   // at profiling tools.
            //   if (typeof property === 'function' && spec.displayName) {
            //     proto[name].displayName = spec.displayName + '_' + name;
            //   }
            // }
          }
        }
      }
    }
  }

  function mixStaticSpecIntoComponent(Constructor, statics) {
    if (!statics) {
      return;
    }
    for (var name in statics) {
      var property = statics[name];
      if (!statics.hasOwnProperty(name)) {
        continue;
      }

      var isReserved = name in RESERVED_SPEC_KEYS;
      // _invariant(
      //   !isReserved,
      //   'ReactClass: You are attempting to define a reserved ' +
      //     'property, `%s`, that shouldn\'t be on the "statics" key. Define it ' +
      //     'as an instance property instead; it will still be accessible on the ' +
      //     'constructor.',
      //   name
      // );

      var isInherited = name in Constructor;
      // _invariant(
      //   !isInherited,
      //   'ReactClass: You are attempting to define ' +
      //     '`%s` on your component more than once. This conflict may be ' +
      //     'due to a mixin.',
      //   name
      // );
      Constructor[name] = property;
    }
  }

  /**
   * Merge two objects, but throw if both contain the same key.
   *
   * @param {object} one The first object, which is mutated.
   * @param {object} two The second object
   * @return {object} one after it has been mutated to contain everything in two.
   */
  function mergeIntoWithNoDuplicateKeys(one, two) {
    // _invariant(
    //   one && two && typeof one === 'object' && typeof two === 'object',
    //   'mergeIntoWithNoDuplicateKeys(): Cannot merge non-objects.'
    // );

    for (var key in two) {
      if (two.hasOwnProperty(key)) {
        // _invariant(
        //   one[key] === undefined,
        //   'mergeIntoWithNoDuplicateKeys(): ' +
        //     'Tried to merge two objects with the same key: `%s`. This conflict ' +
        //     'may be due to a mixin; in particular, this may be caused by two ' +
        //     'getInitialState() or getDefaultProps() methods returning objects ' +
        //     'with clashing keys.',
        //   key
        // );
        one[key] = two[key];
      }
    }
    return one;
  }

  /**
   * Creates a function that invokes two functions and merges their return values.
   *
   * @param {function} one Function to invoke first.
   * @param {function} two Function to invoke second.
   * @return {function} Function that invokes the two argument functions.
   * @private
   */
  function createMergedResultFunction(one, two) {
    return function mergedResult() {
      var a = one.apply(this, arguments);
      var b = two.apply(this, arguments);
      if (a == null) {
        return b;
      } else if (b == null) {
        return a;
      }
      var c = {};
      mergeIntoWithNoDuplicateKeys(c, a);
      mergeIntoWithNoDuplicateKeys(c, b);
      return c;
    };
  }

  /**
   * Creates a function that invokes two functions and ignores their return vales.
   *
   * @param {function} one Function to invoke first.
   * @param {function} two Function to invoke second.
   * @return {function} Function that invokes the two argument functions.
   * @private
   */
  function createChainedFunction(one, two) {
    return function chainedFunction() {
      one.apply(this, arguments);
      two.apply(this, arguments);
    };
  }

  /**
   * Binds a method to the component.
   *
   * @param {object} component Component whose method is going to be bound.
   * @param {function} method Method to be bound.
   * @return {function} The bound method.
   */
  function bindAutoBindMethod(component, method) {
    var boundMethod = method.bind(component);
    // if (process.env.NODE_ENV !== 'production') {
    //   boundMethod.__reactBoundContext = component;
    //   boundMethod.__reactBoundMethod = method;
    //   boundMethod.__reactBoundArguments = null;
    //   var componentName = component.constructor.displayName;
    //   var _bind = boundMethod.bind;
    //   boundMethod.bind = function(newThis) {
    //     for (
    //       var _len = arguments.length,
    //         args = Array(_len > 1 ? _len - 1 : 0),
    //         _key = 1;
    //       _key < _len;
    //       _key++
    //     ) {
    //       args[_key - 1] = arguments[_key];
    //     }
    //
    //     // User is trying to bind() an autobound method; we effectively will
    //     // ignore the value of "this" that the user is trying to use, so
    //     // let's warn.
    //     if (newThis !== component && newThis !== null) {
    //       if (process.env.NODE_ENV !== 'production') {
    //         warning(
    //           false,
    //           'bind(): React component methods may only be bound to the ' +
    //             'component instance. See %s',
    //           componentName
    //         );
    //       }
    //     } else if (!args.length) {
    //       if (process.env.NODE_ENV !== 'production') {
    //         warning(
    //           false,
    //           'bind(): You are binding a component method to the component. ' +
    //             'React does this for you automatically in a high-performance ' +
    //             'way, so you can safely remove this call. See %s',
    //           componentName
    //         );
    //       }
    //       return boundMethod;
    //     }
    //     var reboundMethod = _bind.apply(boundMethod, arguments);
    //     reboundMethod.__reactBoundContext = component;
    //     reboundMethod.__reactBoundMethod = method;
    //     reboundMethod.__reactBoundArguments = args;
    //     return reboundMethod;
    //   };
    // }
    return boundMethod;
  }

  /**
   * Binds all auto-bound methods in a component.
   *
   * @param {object} component Component whose method is going to be bound.
   */
  function bindAutoBindMethods(component) {
    var pairs = component.__reactAutoBindPairs;
    for (var i = 0; i < pairs.length; i += 2) {
      var autoBindKey = pairs[i];
      var method = pairs[i + 1];
      component[autoBindKey] = bindAutoBindMethod(component, method);
    }
  }

  var IsMountedPreMixin = {
    componentDidMount: function() {
      this.__isMounted = true;
    }
  };

  var IsMountedPostMixin = {
    componentWillUnmount: function() {
      this.__isMounted = false;
    }
  };

  /**
   * Add more to the ReactClass base class. These are all legacy features and
   * therefore not already part of the modern ReactComponent.
   */
  var ReactClassMixin = {
    /**
     * TODO: This will be deprecated because state should always keep a consistent
     * type signature and the only use case for this, is to avoid that.
     */
    replaceState: function(newState, callback) {
      this.updater.enqueueReplaceState(this, newState, callback);
    },

    /**
     * Checks whether or not this composite component is mounted.
     * @return {boolean} True if mounted, false otherwise.
     * @protected
     * @final
     */
    isMounted: function() {
      // if (process.env.NODE_ENV !== 'production') {
      //   warning(
      //     this.__didWarnIsMounted,
      //     '%s: isMounted is deprecated. Instead, make sure to clean up ' +
      //       'subscriptions and pending requests in componentWillUnmount to ' +
      //       'prevent memory leaks.',
      //     (this.constructor && this.constructor.displayName) ||
      //       this.name ||
      //       'Component'
      //   );
      //   this.__didWarnIsMounted = true;
      // }
      return !!this.__isMounted;
    }
  };

  var ReactClassComponent = function() {};
  _assign(
    ReactClassComponent.prototype,
    ReactComponent.prototype,
    ReactClassMixin
  );

  /**
   * Creates a composite component class given a class specification.
   * See https://facebook.github.io/react/docs/top-level-api.html#react.createclass
   *
   * @param {object} spec Class specification (which must define `render`).
   * @return {function} Component constructor function.
   * @public
   */
  function createClass(spec) {
    // To keep our warnings more understandable, we'll use a little hack here to
    // ensure that Constructor.name !== 'Constructor'. This makes sure we don't
    // unnecessarily identify a class without displayName as 'Constructor'.
    var Constructor = identity(function(props, context, updater) {
      // This constructor gets overridden by mocks. The argument is used
      // by mocks to assert on what gets mounted.

      // if (process.env.NODE_ENV !== 'production') {
      //   warning(
      //     this instanceof Constructor,
      //     'Something is calling a React component directly. Use a factory or ' +
      //       'JSX instead. See: https://fb.me/react-legacyfactory'
      //   );
      // }

      // Wire up auto-binding
      if (this.__reactAutoBindPairs.length) {
        bindAutoBindMethods(this);
      }

      this.props = props;
      this.context = context;
      this.refs = emptyObject;
      this.updater = updater || ReactNoopUpdateQueue;

      this.state = null;

      // ReactClasses doesn't have constructors. Instead, they use the
      // getInitialState and componentWillMount methods for initialization.

      var initialState = this.getInitialState ? this.getInitialState() : null;
      // if (process.env.NODE_ENV !== 'production') {
      //   // We allow auto-mocks to proceed as if they're returning null.
      //   if (
      //     initialState === undefined &&
      //     this.getInitialState._isMockFunction
      //   ) {
      //     // This is probably bad practice. Consider warning here and
      //     // deprecating this convenience.
      //     initialState = null;
      //   }
      // }
      // _invariant(
      //   typeof initialState === 'object' && !Array.isArray(initialState),
      //   '%s.getInitialState(): must return an object or null',
      //   Constructor.displayName || 'ReactCompositeComponent'
      // );

      this.state = initialState;
    });
    Constructor.prototype = new ReactClassComponent();
    Constructor.prototype.constructor = Constructor;
    Constructor.prototype.__reactAutoBindPairs = [];

    injectedMixins.forEach(mixSpecIntoComponent.bind(null, Constructor));

    mixSpecIntoComponent(Constructor, IsMountedPreMixin);
    mixSpecIntoComponent(Constructor, spec);
    mixSpecIntoComponent(Constructor, IsMountedPostMixin);

    // Initialize the defaultProps property after all mixins have been merged.
    if (Constructor.getDefaultProps) {
      Constructor.defaultProps = Constructor.getDefaultProps();
    }

    // if (process.env.NODE_ENV !== 'production') {
    //   // This is a tag to indicate that the use of these method names is ok,
    //   // since it's used with createClass. If it's not, then it's likely a
    //   // mistake so we'll warn you to use the static property, property
    //   // initializer or constructor respectively.
    //   if (Constructor.getDefaultProps) {
    //     Constructor.getDefaultProps.isReactClassApproved = {};
    //   }
    //   if (Constructor.prototype.getInitialState) {
    //     Constructor.prototype.getInitialState.isReactClassApproved = {};
    //   }
    // }

    // _invariant(
    //   Constructor.prototype.render,
    //   'createClass(...): Class specification must implement a `render` method.'
    // );

    // if (process.env.NODE_ENV !== 'production') {
    //   warning(
    //     !Constructor.prototype.componentShouldUpdate,
    //     '%s has a method called ' +
    //       'componentShouldUpdate(). Did you mean shouldComponentUpdate()? ' +
    //       'The name is phrased as a question because the function is ' +
    //       'expected to return a value.',
    //     spec.displayName || 'A component'
    //   );
    //   warning(
    //     !Constructor.prototype.componentWillRecieveProps,
    //     '%s has a method called ' +
    //       'componentWillRecieveProps(). Did you mean componentWillReceiveProps()?',
    //     spec.displayName || 'A component'
    //   );
    // }

    // Reduce time spent doing lookups by setting these on the prototype.
    for (var methodName in ReactClassInterface) {
      if (!Constructor.prototype[methodName]) {
        Constructor.prototype[methodName] = null;
      }
    }

    return Constructor;
  }

  return createClass;
}
|}
];

[@bs.module "react"] external reactComponent: 'a = "Component";

[@bs.module "react"] external reactIsValidElement: bool = "isValidElement";

[@bs.module "react"] [@bs.new]
external newReactComponent: unit => {. "updater": 'a} = "Component";

let reactNoopUpdateQueue = newReactComponent()##updater;

let createClass =
  factory(. reactComponent, reactIsValidElement, reactNoopUpdateQueue);
