type t = string

let pp fmt (icon, w, h) =
  match icon with
  | None -> Format.fprintf fmt ""
  | Some icon ->
    Format.fprintf fmt
      {|<image x="40" y="35" width="%f" height="%f" xlink:href="%s"/>|} w h icon

let of_string = function _s -> None
