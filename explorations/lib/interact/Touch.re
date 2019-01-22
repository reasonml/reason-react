module Types = {
  type touchPointIdentifier = int;
  type touchStage =
    | Began
    | Moved
    | Still
    | Ended
    | Cancelled;

  /***
   * A physical touch on the screen.
   */
  type touchPoint = {
    identifier: touchPointIdentifier,
    location: Graphics.Types.point,
    initialLocation: Graphics.Types.point,
    touchStage,
  };
  type touch = {
    timestamp: float,
    stage: touchStage,
    /*
     * Currently, touches shouldn't hold references to a snapshot "view" of
     * their component instances
     */
    view: unit,
    window: unit,
    privateTouchData: touchPoint,
  };
};
