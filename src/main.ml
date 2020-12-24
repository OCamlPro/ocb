open Ocb

let () =
  let label = ref "label" in
  let color = ref Color.Blue in
  let style = ref Style.Classic in
  let icon = ref None in
  let icon_width = ref 13. in
  let label_color = ref (Color.Custom "555") in
  let scale = ref 1. in
  let status = ref "status" in

  let speclist =
    [ ("--label", Arg.String (fun s -> label := s), "badge label")
    ; ( "--color"
      , Arg.String (fun s -> color := Color.of_string s)
      , "badge color" )
    ; ( "--style"
      , Arg.String (fun s -> style := Style.of_string s)
      , "badge style" )
    ; ( "--labelcolor"
      , Arg.String (fun s -> label_color := Color.of_string s)
      , "label color" )
    ; ("--status", Arg.String (fun s -> status := s), "status")
    ; ("--scale", Arg.Float (fun f -> scale := f), "scale")
    ; ("--icon", Arg.String (fun s -> icon := Icon.of_string s), "icon")
    ; ("--iconwidth", Arg.Float (fun f -> icon_width := f), "icon width")
    ]
  in

  Arg.parse speclist
    (fun s -> failwith @@ Format.sprintf "unknown arg `%s`" s)
    "bla";

  let label = !label in
  let color = !color in
  let style = !style in
  let icon = !icon in
  let icon_width = !icon_width in
  let label_color = !label_color in
  let scale = !scale in
  let status = !status in

  Gen.mk Format.std_formatter ~label ~color ~style ~icon ~icon_width ~scale
    ~label_color ~status ()
