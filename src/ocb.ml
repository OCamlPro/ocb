open Ocb
open Cmdliner
open Term.Syntax

(* Helpers *)
let color_conv = Arg.conv (Color.of_string, Color.pp)

let float_conv =
  Arg.conv
    ( (fun s ->
        match Float.of_string_opt s with
        | None -> Error (`Msg "invalid float")
        | Some f -> Ok f )
    , Fmt.float )

let string_conv = Arg.conv (Result.ok, Fmt.string)

let style_conv = Arg.conv (Style.of_string, Style.pp)

let icon_conv = Arg.conv (Icon.of_string, Fmt.option ~none:Fmt.nop Fmt.string)

(* Terms *)
let color =
  let doc = "color" in
  Arg.(value & opt color_conv Color.Blue & info [ "color" ] ~docv:"COLOR" ~doc)

let icon =
  let doc = "icon" in
  Arg.(value & opt icon_conv None & info [ "icon" ] ~docv:"ICON" ~doc)

let icon_width =
  let doc = "icon width" in
  Arg.(value & opt float_conv 13.0 & info [ "iconwidth" ] ~docv:"FLOAT" ~doc)

let label =
  let doc = "label" in
  Arg.(value & opt string_conv "label" & info [ "label" ] ~docv:"STRING" ~doc)

let label_color =
  let doc = "label color" in
  Arg.(
    value
    & opt color_conv (Color.Custom "555")
    & info [ "labelcolor" ] ~docv:"COLOR" ~doc )

let scale =
  let doc = "scale" in
  Arg.(value & opt float_conv 1.0 & info [ "scale" ] ~docv:"FLOAT" ~doc)

let status =
  let doc = "status" in
  Arg.(value & opt string_conv "status" & info [ "status" ] ~docv:"STRING" ~doc)

let style =
  let doc = "style" in
  Arg.(
    value & opt style_conv Style.Classic & info [ "style" ] ~docv:"STYLE" ~doc )

(* Command *)
let gen_cmd =
  let+ label
  and+ color
  and+ style
  and+ icon
  and+ icon_width
  and+ scale
  and+ label_color
  and+ status in
  Gen.mk Fmt.stdout ~label ~color ~style ~icon ~icon_width ~scale ~label_color
    ~status ()

let gen_info =
  let doc = "SVG badge generator." in
  let man = [ `S Manpage.s_bugs; `P "Léo Andrès <contact@ndrs.fr>" ] in
  Cmd.info "ocb" ~version:"%%VERSION%%" ~doc ~man

let cli =
  let open Cmdliner in
  Cmd.v gen_info gen_cmd

let () = exit @@ Cmdliner.Cmd.eval cli
