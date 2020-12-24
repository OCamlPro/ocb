type t =
  | Classic
  | Flat

let of_string = function
  | "classic" -> Classic
  | "flat" -> Flat
  | s -> failwith @@ Format.sprintf "unknown style `%s`" s
