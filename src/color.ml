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
  | Green -> Format.fprintf fmt "3C1"
  | Blue -> Format.fprintf fmt "08C"
  | Red -> Format.fprintf fmt "E43"
  | Yellow -> Format.fprintf fmt "DB1"
  | Orange -> Format.fprintf fmt "F73"
  | Purple -> Format.fprintf fmt "94E"
  | Pink -> Format.fprintf fmt "E5B"
  | Grey -> Format.fprintf fmt "999"
  | Cyan -> Format.fprintf fmt "1BC"
  | Black -> Format.fprintf fmt "2A2A2A"
  | Custom s -> Format.fprintf fmt "%s" s

(* TODO: check s ? *)

let of_string = function
  | "green" -> Green
  | "blue" -> Blue
  | "red" -> Red
  | "yellow" -> Yellow
  | "orange" -> Orange
  | "purple" -> Purple
  | "pink" -> Pink
  | "gray"
  | "grey" ->
    Grey
  | "cyan" -> Cyan
  | "black" -> Black
  | custom -> Custom custom
