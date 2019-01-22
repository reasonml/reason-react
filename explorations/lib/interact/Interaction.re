/***
 * `Interaction`: Immutable "interaction detectors"  for clicks, touch
 * gestures, and more.
 *
 * Models state machines for interactions in an immutable way - feed the
 * interaction detector touches, and the result is a new version of the
 * interaction detector with its internal state updated.
 * 
 * Provides an OO inspired API with an immutable spin. It uses pure records
 * without any object system to implement a kind of extensible inheritance,
 * including dynamic dispatch!
 * Uses explicitly extensible records for "faux-row-polymorphism". We can make
 * sugar for these patterns if we find them effective.
 */

/**
 * InteractionDetectorStatePossible:
 *
 *   Has not "detected" an interaction, but is potentially interpreting
 *   touches. Detectors start out in this state, and return to it eventually.
 *
 * InteractionDetectorStateBegan (Continuous Only):
 *
 *   The detector has received touch events and now considers itself in a
 *   notable "detecting" state for the first time since it last transitioned to
 *   the `Possible` state.
 *
 *  InteractionDetectorStateChanged (Continuous Only):
 *
 *   The detector has received some notable touch events while having already
 *   transitioned to InteractionDetectorStateBegan in a prior event loop.
 *
 *  InteractionDetectorStateCancelled (Continuous Only):
 *
 *   Like a Failure, but will be reported to delegates. At start of next event
 *   loop, will be reset to InteractionDetectorStatePossible.
 *
 *  InteractionDetectorStateFailed (Continuous Only):
 *
 *   The detector has observed a stream of touch events that it knows it cannot
 *   possibly detect as an interaction. This transition will not be reported to
 *   delegates. At start of next event loop, will be reset to
 *   InteractionDetectorStatePossible.
 *
 *  InteractionDetectorStateDetected (Discrete Only):
 *
 *   The detector has determined that the stream of touch events it has
 *   observed should be detected as a discrete interaction. It will report this
 *   to its delegate. At start of next event loop, will be reset to
 *   InteractionDetectorStatePossible.
 *
 *  InteractionDetectorStateEnded (Continuous Only):
 *
 *   Like, InteractionDetectorStateDetected but for continuous interactions.
 *
 *
 * There are two types of interactions - discrete and continuous.
 *
 * Discrete: report some event such as "Tap", and don't report progress along
 * the way - they don't transition through `Began` and `Changed` states. They
 * also cannot be `Cancelled` nor `Fail`.
 *
 * Continuous:
 *
 * But what about the missing third category, that report among some finite set
 * of changes - such as Pressable, which reports when touches enter/leave, and
 * then finally are released successfully? They must be considered continuous.
 *
 */;

let emptyClassification = ([], [], [], []);

/**
 * Calling methods on an instance is much like JS:
 *
 *    obj.methods.someMethod(obj, arg);
 *
 * Which resembles JS's:
 *
 *    obj.someMethod.call(obj, arg);
 *
 * Like JS, Reason may implement sugar for method calling to automatically pass
 * `self`.
 *
 *    obj->someMethod(firstArg);
 *
 *    // Example with named args
 *    obj->someMethod(firstArg, ~andANamedArg=20);
 *
 *
 * To subclass `Interaction`, make your own module with the following: (This
 * example shows a "Final" extended class. You may also make your subclass, in
 * turn, extensible)
 *
 * let module TapInteractionDetector = {
 *   type methods = Interaction.Types.methods(tapInteractionFields, tapInteractionMethods)
 *   and instance = Interaction.Types.instance(tapInteractionFields ,tapInteractionMethods)
 *   and tapInteractionFields = {
 *     tapField: float,
 *   }
 *   and tapInteractionMethods = {
 *     tapMethod: instance => unit
 *   };
 *
 *   let methods: methods = {
 *     ...Interaction.extendMethods {
 *       tapMethod: self => ...
 *     },
 *     touchesMoved: (self, movedTouches, touches) => {
 *       {...self, state: InteractionDetectorStateFailed};
 *     },
 *     // You can overide methods and dynamic dispatch will work!
 *     touchesBegan: (self, beganTouches, touches) => self.methods.tapMethod(self)
 *   };
 *
 *   let create () => {
 *     ...Interaction.create(),
 *     methods,
 *     ext: {
 *       tapField: 0.0,
 *     }
 *   };
 * };
 *
 *
 * Now, to allow two different subclasses to comingle in the same data
 * structure, you must make the extension type variable existential. (Again
 * much of this may be automated by sugar and/or type system changes).
 *
 *    type opaqueInteractionHandler =
 *      | InteractionHandler(ReactKit.Interaction.Types.instance('i, 'm))
 *        : opaqueInteractionHandler;
 *
 *    /**
 *     * TapInteractionDetector.instance is just an alis for
 *     * Interaction.Types.instance(x, y) - with some specific x, y.
 *     */
 *    let tap: Interaction.Types.instance(x, y) = ...;
 *    let pinch: Interaction.Types.instance(a, b) = ...;
 *
 *    let lst: list(opaqueInteractionHandler) = [
 *      InteractionHandler(tap),
 *      InteractionHandler(pinch)
 *    ];
 *
 * 1. This preserves reference identity of the items inside of the opaque
 * wrapper (unlike first class module coercion!)
 *
 * 2. This allows you to recover the interaction instance but without being
 * able to assume anything about the particular way it was extended.
 *
 * TODO: A very nice, minimalist OO style pattern would be to allow data/fields
 * to be extensible, but not methods. This would make there be a single type
 * variable 'ext, and would lend itself to a syntactic sugar. This would allow
 * a base class to be defined, and extended with new fields, non-final methods
 * even being able to be overridden with full dynamic dispatch - however, any
 * *new* methods must be dispatched statically, via the module name.
 */;

module Types = {
  type interactionDetectorState =
    | InteractionDetectorStatePossible
    | InteractionDetectorStateBegan
    | InteractionDetectorStateChanged
    | InteractionDetectorStateCancelled
    | InteractionDetectorStateFailed
    | InteractionDetectorStateDetected
    | InteractionDetectorStateEnded;

  /***
   * Concrete type of a non-subclassed interaction instance. Not typically useful,
   * but subclasses could
   */
  type t = instance(unit, unit)
  /*
   * Concrete type of a non-subclassed interaction class. Not typically useful.
   */
  and clss = methods(unit, unit)
  /*
   * Type family for all instances whos classes subclass Interaction.
   */
  and instance('fieldExtension, 'methodExtension) = {
    /* Instances have a pointer back to their class's method table. */
    methods: methods('fieldExtension, 'methodExtension),
    /***
     * The touches that are currently being considered. Touches are only added
     * to this list upon "begin" events, and this list is cleared when
     * transitioning to a "final" state such as Ended/Failed/Canceled. The
     * effect is that any touches that began in previous "interactions" are
     * conveniently ignored.
     */
    tracksTouchIds: list(Touch.Types.touchPointIdentifier),
    interactionDetectorId: InteractionId.interactionDetectorId,
    state: interactionDetectorState,
    /***
     * For determining if an update actually occurred.
     */
    version: int,
    enabled: bool,
    ext: 'fieldExtension,
  }
  /***
   * Type family for all classes that subclass Interaction.
   *
   * "Constraints" are actually pretty simple. They just help you write nicer
   * type abstractions. They did not make possible anything new here, just
   * helped with writing clearer type definitions with fewer repeated terms.
   * For example, previously methods was `methods 'fieldExtenson 'methodExtension`.
   *
   * See: http://stackoverflow.com/a/24513141
   */
  and methods('fieldExtension, 'methodExtension) = {
    serialize: 'instanceType => string,
    update: ('instanceType, interactionDetectorState) => 'instanceType,
    touchesBegan:
      ('instanceType, list(Touch.Types.touch), list(Touch.Types.touch)) =>
      'instanceType,
    touchesMoved:
      ('instanceType, list(Touch.Types.touch), list(Touch.Types.touch)) =>
      'instanceType,
    touchesEnded:
      ('instanceType, list(Touch.Types.touch), list(Touch.Types.touch)) =>
      'instanceType,
    touchesCancelled:
      ('instanceType, list(Touch.Types.touch), list(Touch.Types.touch)) =>
      'instanceType,
    reset: 'instanceType => 'instanceType,
    ignoreTouch: ('instanceType, Touch.Types.touch) => 'instanceType,
    canBePreventedByInteractionDetector:
      't2 't2m.
      ('instanceType, instance('t2, 't2m)) => bool,

    canPreventInteractionDetector:
      't2 't2m.
      ('instanceType, instance('t2, 't2m)) => bool,

    shouldRequireFailureOfInteractionDetector:
      't2 't2m.
      ('instanceType, instance('t2, 't2m)) => bool,

    shouldBeRequiredToFailByInteractionDetector:
      't2 't2m.
      ('instanceType, instance('t2, 't2m)) => bool,

    ext: 'methodExtension,
  }
  constraint 'instanceType = instance('fieldExtension, 'methodExtension);
  type interactionSubclass =
    | InteractionSubclass(instance('fieldExtension, 'methodExtension))
      : interactionSubclass;
};

open Types;

let interactionStateToString = state =>
  switch (state) {
  | InteractionDetectorStatePossible => "InteractionDetectorStatePossible"
  | InteractionDetectorStateBegan => "InteractionDetectorStateBegan"
  | InteractionDetectorStateChanged => "InteractionDetectorStateChanged"
  | InteractionDetectorStateCancelled => "InteractionDetectorStateCancelled"
  | InteractionDetectorStateFailed => "InteractionDetectorStateFailed"
  | InteractionDetectorStateDetected => "InteractionDetectorStateDetected"
  | InteractionDetectorStateEnded => "InteractionDetectorStateEnded"
  };

let rec appendTrackingImpl = (curTracking, touches) =>
  switch (curTracking, touches) {
  | (_, []) => curTracking
  | (curTracking, [{Touch.Types.stage: Began, privateTouchData}, ...tl]) =>
    appendTrackingImpl([privateTouchData.identifier, ...curTracking], tl)
  | (curTracking, [_, ...tl]) => appendTrackingImpl(curTracking, tl)
  };

let appendTracking = (instance, changedTouches) => {
  let nextTracksTouches =
    appendTrackingImpl(instance.tracksTouchIds, changedTouches);
  if (nextTracksTouches === instance.tracksTouchIds) {
    instance;
  } else {
    {...instance, tracksTouchIds: nextTracksTouches};
  };
};

let handleInteractionTouches = ((changedTouches, touches), interaction) => {
  let nextInteraction = appendTracking(interaction, changedTouches);
  switch (
    TouchUtils.classifyTouches(
      emptyClassification,
      changedTouches,
      nextInteraction.tracksTouchIds,
    )
  ) {
  | ([], [], [], []) => interaction
  | (curBegin, curMove, curEnd, curCancel) =>
    let nextInteraction =
      switch (curBegin) {
      | [] => nextInteraction
      | [_, ..._] =>
        nextInteraction.methods.touchesBegan(
          nextInteraction,
          curBegin,
          touches,
        )
      };
    let nextInteraction =
      switch (curMove) {
      | [] => nextInteraction
      | [_, ..._] =>
        nextInteraction.methods.touchesMoved(
          nextInteraction,
          curMove,
          touches,
        )
      };
    let nextInteraction =
      switch (curEnd) {
      | [] => nextInteraction
      | [_, ..._] =>
        nextInteraction.methods.touchesEnded(nextInteraction, curEnd, touches)
      };
    let nextInteraction =
      switch (curCancel) {
      | [] => nextInteraction
      | [_, ..._] =>
        nextInteraction.methods.touchesCancelled(
          nextInteraction,
          curCancel,
          touches,
        )
      };
    nextInteraction;
  };
};

let acknowledgeAttempt = (curInteraction, touchData, delegate) => {
  let interactionAttempt =
    handleInteractionTouches(touchData, curInteraction);
  if (interactionAttempt === curInteraction) {
    (interactionAttempt, []);
  } else {
    let finalInteraction =
      switch (interactionAttempt.state) {
      | InteractionDetectorStateCancelled
      | InteractionDetectorStateFailed
      | InteractionDetectorStateDetected
      | InteractionDetectorStateEnded =>
        interactionAttempt.methods.reset(interactionAttempt)
      | InteractionDetectorStatePossible
      | InteractionDetectorStateBegan
      | InteractionDetectorStateChanged => interactionAttempt
      };
    let dispatchWork =
      switch (interactionAttempt.state) {
      | InteractionDetectorStateBegan
      | InteractionDetectorStateDetected
      | InteractionDetectorStateChanged
          when curInteraction.version !== interactionAttempt.version => [
          (
            InteractionSubclass(interactionAttempt),
            Core.Dispatch(finalInteraction, delegate),
          ),
        ]
      | _ => []
      };
    (finalInteraction, dispatchWork);
  };
};

/*
 * Extension *had* to occur through a function invocation which generated a
 * *new* value with types determined by `ext` parameter. It was not sufficient
 * to create one copy of `methods`, and then share that one instance in
 * subclasses.
 *
 * The following would not work:
 *
 *     let baseMethods = {...., ext: ()};
 *
 *     let subclassMethods = {...baseMethods, ext: {...}};
 *
 * There were various issues with either being able to extend and reimplement a
 * base class method.
 *
 * I had even went as far as to define methods as the following:
 *
 *  touchesBegan: 'i 'm .
 *     instance 'i 'm => (list touch) => (list touch) => 'instance 'i 'm,
 *
 * The problem was that, while this is polymorphic to allow extension, it's
 * *too* polymorphic. When trying to extend and reimplement one of these
 * methods in a way that "refines" the polymorphism so that it can make some
 * assumptions about your subclass data shape, the type system complains that
 * you're not allowed to make it "less generic". That makes sense.
 *
 * I believe that this explicit invocation to generate a new method table acts
 * as "nominal" subtyping.
 */
let extendMethods = ext => {
  touchesBegan: (self, beganTouches, touches) => self,
  touchesMoved: (self, movedTouches, touches) => self,
  touchesEnded: (self, endedTouches, touches) => self,
  touchesCancelled: (self, cancelledTouches, touches) => self,
  update: (self, nextState) => {
    ...self,
    state: nextState,
    version: self.version + 1,
  },
  reset: self => {
    ...self,
    tracksTouchIds: [],
    state: InteractionDetectorStatePossible,
    version: self.version + 1,
  },
  /* TODO: This is intended to be called not implemented/overriden  */
  ignoreTouch: (self, touch) => {
    ...self,
    tracksTouchIds:
      TouchUtils.removeTouchIds(
        self.tracksTouchIds,
        touch.Touch.Types.privateTouchData.identifier,
      ),
  },
  canBePreventedByInteractionDetector: (self, other) => true,
  canPreventInteractionDetector: (self, other) => false,
  shouldRequireFailureOfInteractionDetector: (self, other) => false,
  shouldBeRequiredToFailByInteractionDetector: (self, other) => false,
  serialize: self => interactionStateToString(self.state),
  ext,
};

let methods: clss = extendMethods();

let create = (): t => {
  methods,
  /**
   * The touches that are currently being considered. Touches are only added to
   * this list upon "begin" events, and this list is cleared when transitioning
   * to a "final" state such as Ended/Failed/Canceled. The effect is that any
   * touches that began in previous "interactions" are conveniently ignored.
   */
  tracksTouchIds: [],
  interactionDetectorId: InteractionId.createInteractionDetectorId(),
  state: InteractionDetectorStatePossible,
  enabled: true,
  version: 0,
  ext: (),
};
