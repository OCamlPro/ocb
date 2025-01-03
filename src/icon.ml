type t = string

let pp fmt (icon, w, h) =
  match icon with
  | None -> ()
  | Some icon ->
    Fmt.pf fmt {|<image x="40" y="35" width="%f" height="%f" xlink:href="%s"/>|}
      w h icon

let of_string (_s : string) : (t option, _) Result.t =
  Error (`Msg "icons from command line are not implemented yet")
