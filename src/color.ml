type t =
  | Green
  | Blue
  | Red
  | Yellow
  | Orange
  | Purple
  | Pink
  | Grey
  | Cyan
  | Black
  | Custom of string

let pp fmt = function
  | Green -> Fmt.string fmt "3C1"
  | Blue -> Fmt.string fmt "08C"
  | Red -> Fmt.string fmt "E43"
  | Yellow -> Fmt.string fmt "DB1"
  | Orange -> Fmt.string fmt "F73"
  | Purple -> Fmt.string fmt "94E"
  | Pink -> Fmt.string fmt "E5B"
  | Grey -> Fmt.string fmt "999"
  | Cyan -> Fmt.string fmt "1BC"
  | Black -> Fmt.string fmt "2A2A2A"
  | Custom s -> Fmt.string fmt s

(* TODO: check s ? *)

let of_string = function
  | "green" -> Ok Green
  | "blue" -> Ok Blue
  | "red" -> Ok Red
  | "yellow" -> Ok Yellow
  | "orange" -> Ok Orange
  | "purple" -> Ok Purple
  | "pink" -> Ok Pink
  | "gray" | "grey" -> Ok Grey
  | "cyan" -> Ok Cyan
  | "black" -> Ok Black
  | custom -> Ok (Custom custom)
