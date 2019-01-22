/***
 * let obj = {
 *   field: 100,
 *   objMethod: function(msg) {
 *     console.log(this.field + " " + msg);
 *   }
 * };
 * let targetSelector = new TargetSelector(obj, "objMethod");
 * targetSelector.invoke("this is the message");
 *
 *
 * This represents:
 *
 * let obj = {
 *   field: 100
 * };
 * let func = (o, msg) => {
 *   Printf.sprintf("%d %s", o.field, msg);
 * };
 * let targetSelector = TargetSelector(obj, func);
 * targetSelector.invoke("this is the message");
 *
 *
 *
 * targetSelector (firstParameter, function);
 */
type targetSelector('argument, 'returnVal) =
  | TargetSelector('t, ('t, 'argument) => 'returnVal)
    : targetSelector('argument, 'returnVal);

/*
 * A delegate description suitable for imutable trees where an extra identifier
 * is needed, in order to lazily resolve the actual node at the time of
 * invocation (trapping the node in this data structure would trap a stale copy
 * of it).
 *
 * One challenge (possible limitation?) is when you want the function itself to
 * be polymorphic in one of the arguments.
 */
type delegate('id, 'resolved, 'arg, 'ret) =
  | NoDelegate
  | Delegate('id, ('id, 'resolved, 'arg) => 'ret);

/***
 * A `delegate` and its argument together, making the type of that argument
 * opaque, so that many delegate dispatches may coexist in a single data
 * structure.
 */
type dispatch('id, 'resolved, 'ret) =
  | Dispatch('arg, delegate('id, 'resolved, 'arg, 'ret))
    : dispatch('id, 'resolved, 'ret);
