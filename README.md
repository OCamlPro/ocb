# ocb

`ocb` (OCaml Badgen) is an [OCaml] library for [SVG] badge generation. There's also a command-line tool provided.

## Quick start

### Using the command-line tool

```sh
ocb --label Hello --color green --style flat --labelcolor white --status Goodbye > out.svg && xdg-open out.svg
```

Gives the following result: [![cli example](example/cli.svg)](example/cli.svg).

### Using the library

```ml
let () =
  let open Ocb in
  Gen.mk Format.std_formatter ~label:"Hello" ~color:Color.Blue ~style:Style.Flat ~label_color:Color.White ~status:"Goodbye" ()
```

## Credits

This project is inspired by [badgen].

[badgen]: https://github.com/badgen/badgen
[OCaml]: https://ocaml.org/
[SVG]: https://en.wikipedia.org/wiki/Scalable_Vector_Graphics
