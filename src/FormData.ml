(* Provides a way to easily construct a set of key/value pairs representing form fields and their values, which can then be easily sent using the XMLHttpRequest.send() method. It uses the same format a form would use if the encoding type were set to "multipart/form-data". *)

module Iterator = struct
  type 'a iterator
  type 'a t = 'a iterator
  type 'a value = { done_ : bool option; [@mel.as "done"] value : 'a option }

  external next : 'a t -> 'a value = "next" [@@mel.send]
  external toArray : 'a t -> 'a array = "Array.from"
  external toArrayWithMapper : 'a t -> f:('a -> 'b) -> 'b array = "Array.from"
end

type t
type file
type blob
type entryValue

let classify : entryValue -> [> `String of string | `File of file ] =
  fun t ->
  if Js.typeof t = "string" then `String (Obj.magic t)
  else `File (Obj.magic t)

external make : unit -> t = "FormData" [@@mel.new]
external append : string -> string -> unit = "append" [@@mel.send.pipe: t]
external delete : string -> unit = "delete" [@@mel.send.pipe: t]
external get : string -> entryValue option = "get" [@@mel.send.pipe: t]
external getAll : string -> entryValue array = "getAll" [@@mel.send.pipe: t]
external set : string -> string -> unit = "set" [@@mel.send.pipe: t]
external has : string -> bool = "has" [@@mel.send.pipe: t]
external keys : t -> string Iterator.t = "keys" [@@mel.send]
external values : t -> entryValue Iterator.t = "values" [@@mel.send]

external appendObject : string -> < .. > Js.t -> ?filename:string -> unit
  = "append"
[@@mel.send.pipe: t]

external appendBlob : string -> blob -> ?filename:string -> unit = "append"
[@@mel.send.pipe: t]

external appendFile : string -> file -> ?filename:string -> unit = "append"
[@@mel.send.pipe: t]

external setObject : string -> < .. > Js.t -> ?filename:string -> unit = "set"
[@@mel.send.pipe: t]

external setBlob : string -> blob -> ?filename:string -> unit = "set"
[@@mel.send.pipe: t]

external setFile : string -> file -> ?filename:string -> unit = "set"
[@@mel.send.pipe: t]

external entries : t -> (string * entryValue) Iterator.t = "entries"
[@@mel.send]
