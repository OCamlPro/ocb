let calc_width =
  let table = Verdana.table in
  let len = Array.length table in
  let fallback = table.(64) in
  fun text ->
    let total = ref 0. in
    String.iter
      (fun c ->
        let code = Char.code c in
        let width =
          if code >= len then
            fallback
          else
            table.(code)
        in
        total := !total +. width )
      text;
    !total

let sanitize s =
  let buffer = Buffer.create @@ String.length s in
  let fmt = Format.formatter_of_buffer buffer in
  let add = Format.fprintf fmt in
  let add_c = Buffer.add_char buffer in
  String.iter
    (function
      | '&' -> add "&amp;"
      | '<' -> add "&lt;"
      | '>' -> add "&gt;"
      | '\'' -> add "&apos;"
      | '\"' -> add "&quot;"
      | '@' -> add "&commat;"
      | c -> add_c c )
    s;
  Buffer.contents buffer

let create_accessible_text label status =
  if String.equal label "" then
    status
  else
    Format.sprintf "%s: %s" label status

let bare fmt ?(color = Color.Blue) ?(style = Style.Classic) ?(scale = 1.)
    ~status =
  let st_text_width = calc_width status in
  let st_rect_width = st_text_width +. 115. in
  let status = sanitize status in
  let width = scale *. st_rect_width /. 10. in
  let height = scale *. 20. in
  match style with
  | Classic ->
    Format.fprintf fmt
      {|<svg width="%f" height="%f" viewBox="0 0 %f 200" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="%s">
  <title>%s</title>
  <linearGradient id="a" x2="0" y2="100%%">
    <stop offset="0" stop-opacity=".1" stop-color="#EEE"/>
    <stop offset="1" stop-opacity=".1"/>
  </linearGradient>
  <mask id="m"><rect width="%f" height="200" rx="30" fill="#FFF"/></mask>
  <g mask="url(#m)">
    <rect width="%f" height="200" fill="#%a" x="0"/>
    <rect width="%f" height="200" fill="url(#a)"/>
  </g>
  <g aria-hidden="true" fill="#fff" text-anchor="start" font-family="Verdana,DejaVu Sans,sans-serif" font-size="110">
    <text x="65" y="148" textLength="%f" fill="#000" opacity="0.25">%s</text>
    <text x="55" y="138" textLength="%f">%s</text>
  </g>
</svg>@.|}
      width height st_rect_width status status st_rect_width st_rect_width
      Color.pp color st_rect_width st_text_width status st_text_width status
  | Flat ->
    Format.fprintf fmt
      {|<svg width="%f" height="%f" viewBox="0 0 %f 200" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="%s">
  <title>%s</title>
  <g>
    <rect fill="#%a" x="0" width="%f" height="200"/>
  </g>
  <g aria-hidden="true" fill="#fff" text-anchor="start" font-family="Verdana,DejaVu Sans,sans-serif" font-size="110">
    <text x="65" y="148" textLength="%f" fill="#000" opacity="0.1">%s</text>
    <text x="55" y="138" textLength="%f">%s</text>
  </g>
</svg>@.|}
      width height st_rect_width status status Color.pp color st_rect_width
      st_text_width status st_text_width status

let mk fmt ?(label = "") ?(color = Color.Blue) ?(style = Style.Classic)
    ?(icon = None) ?(icon_width = 13.) ?(label_color = Color.Custom "555")
    ?(scale = 1.) ~status () =
  if String.equal label "" && Option.is_none icon then
    bare fmt ~status ~color ~style ~scale
  else
    let icon_width = icon_width *. 10. in
    let icon_span_width =
      if Option.is_none icon then
        0.
      else if String.equal label "" then
        icon_width -. 18.
      else
        icon_width +. 30.
    in
    let sb_text_start =
      if Option.is_none icon then
        50.
      else
        icon_width +. 50.
    in
    let sb_text_width = calc_width label in
    let st_text_width = calc_width status in
    let sb_rect_width = sb_text_width +. 100. +. icon_span_width in
    let st_rect_width = st_text_width +. 100. in
    let width = sb_rect_width +. st_rect_width in
    let xlink =
      if Option.is_none icon then
        ""
      else
        {| xmlns:xlink="http://www.w3.org/1999/xlink"|}
    in
    let label = sanitize label in
    let status = sanitize status in
    let accessible_text = create_accessible_text label status in
    let svg_width = scale *. width /. 10. in
    let svg_height = scale *. 20. in
    match style with
    | Classic ->
      Format.fprintf fmt
        {|<svg width="%f" height="%f" viewBox="0 0 %f 200" xmlns="http://www.w3.org/2000/svg"%s role="img" aria-label="%s">
  <title>%s</title>
  <linearGradient id="a" x2="0" y2="100%%">
    <stop offset="0" stop-opacity=".1" stop-color="#EEE"/>
    <stop offset="1" stop-opacity=".1"/>
  </linearGradient>
  <mask id="m"><rect width="%f" height="200" rx="30" fill="#FFF"/></mask>
  <g mask="url(#m)">
    <rect width="%f" height="200" fill="#%a"/>
    <rect width="%f" height="200" fill="#%a" x="%f"/>
    <rect width="%f" height="200" fill="url(#a)"/>
  </g>
  <g aria-hidden="true" fill="#fff" text-anchor="start" font-family="Verdana,DejaVu Sans,sans-serif" font-size="110">
    <text x="%f" y="148" textLength="%f" fill="#000" opacity="0.25">%s</text>
    <text x="%f" y="138" textLength="%f">%s</text>
    <text x="%f" y="148" textLength="%f" fill="#000" opacity="0.25">%s</text>
    <text x="%f" y="138" textLength="%f">%s</text>
  </g>
  %a</svg>@.|}
        svg_width svg_height width xlink accessible_text accessible_text width
        sb_rect_width Color.pp label_color st_rect_width Color.pp color
        sb_rect_width width (sb_text_start +. 10.) sb_text_width label
        sb_text_start sb_text_width label (sb_rect_width +. 55.) st_text_width
        status (sb_rect_width +. 45.) st_text_width status Icon.pp
        (icon, icon_width, 130.)
    | Flat ->
      Format.fprintf fmt
        {|<svg width="%f" height="%f" viewBox="0 0 %f 200" xmlns="http://www.w3.org/2000/svg"%s role="img" aria-label="%s">
  <title>%s</title>
  <g>
    <rect fill="#%a" width="%f" height="200"/>
    <rect fill="#%a" x="%f" width="%f" height="200"/>
  </g>
  <g aria-hidden="true" fill="#fff" text-anchor="start" font-family="Verdana,DejaVu Sans,sans-serif" font-size="110">
    <text x="%f" y="148" textLength="%f" fill="#000" opacity="0.1">%s</text>
    <text x="%f" y="138" textLength="%f">%s</text>
    <text x="%f" y="148" textLength="%f" fill="#000" opacity="0.1">%s</text>
    <text x="%f" y="138" textLength="%f">%s</text>
  </g>
  %a</svg>@.|}
        svg_width svg_height width xlink accessible_text accessible_text
        Color.pp label_color sb_rect_width Color.pp color sb_rect_width
        st_rect_width (sb_text_start +. 10.) sb_text_width label sb_text_start
        sb_text_width label (sb_rect_width +. 55.) st_text_width status
        (sb_rect_width +. 45.) st_text_width status Icon.pp
        (icon, icon_width, 132.)
