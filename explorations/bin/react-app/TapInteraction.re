/***
 * This is just an Example of a "Final Class" (not for use) - otherwise the
 * same as the more general TapInteraction.
 */
open Interact;
open Interact.Touch.Types;
open Graphics.Types;

type tapInteractionFields = {
  cancelThreshold: float,
  shouldLogSuccess: bool,
  numberOfTapsRequired: int,
  numberOfTouchesRequired: int,
  currentTapCount: int,
};

type tapInteractionMethods = {
  /* Log on success */
  logTapSuccess: instance => unit,
}
and methods =
  Interaction.Types.methods(tapInteractionFields, tapInteractionMethods)
and instance =
  Interaction.Types.instance(tapInteractionFields, tapInteractionMethods)
/**
 * `t` happens to be the same as instance, but wouldn't be if instance was
 * extensible.
 */
and t = instance;

let movedTooFar = (tapInteraction: instance, touch) => {
  let location = touch.privateTouchData.location;
  let initialLocation = touch.privateTouchData.initialLocation;
  abs_float(initialLocation.x -. location.x)
  > tapInteraction.ext.cancelThreshold
  || abs_float(initialLocation.y -. location.y)
  > tapInteraction.ext.cancelThreshold;
};

let rec methods: methods = {
  /* Custom subclass methods */
  ...
    Interaction.extendMethods({
      logTapSuccess: self =>
        self.ext.shouldLogSuccess ? print_string("Did tap\n") : (),
    }),
  /* Override base class methods */
  touchesMoved: (self, movedTouches, touches) => {
    let aTouchIsTooFar =
      List.exists(t => movedTooFar(self, t), movedTouches);
    if (!aTouchIsTooFar) {
      self;
    } else {
      self.methods.update(self, InteractionDetectorStateFailed);
    };
  },
  touchesEnded: (self, endedTouches, touches) =>
    self.methods.update(self, InteractionDetectorStateDetected),
  touchesBegan: (self, beganTouches, touches) => self,
};

let create = () => {
  ...Interaction.create(),
  methods,
  ext: {
    cancelThreshold: 10.0,
    shouldLogSuccess: false,
    numberOfTapsRequired: 1,
    numberOfTouchesRequired: 1,
    currentTapCount: 0,
  },
};
