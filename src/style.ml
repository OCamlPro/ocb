type t =
  | Classic
  | Flat

let of_string = function
  | "classic" -> Ok Classic
  | "flat" -> Ok Flat
  | s -> Fmt.error_msg "unknown style `%s`" s

let pp fmt = function
  | Classic -> Fmt.string fmt "classic"
  | Flat -> Fmt.string fmt "flat"
