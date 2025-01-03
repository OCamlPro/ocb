(lang dune 3.0)

(name ocb)

(license ISC)

(authors "OCamlPro <contact@ocamlpro.com>")

(maintainers "OCamlPro <contact@ocamlpro.com>")

(source
 (github OCamlPro/ocb))

(homepage https://ocamlpro.github.io/ocb/)

(documentation https://ocamlpro.github.io/ocb/api/)

(generate_opam_files true)

(package
 (name ocb)
 (synopsis "SVG badge generator")
 (description
   "An OCaml library for SVG badge generation. There's also a command-line tool provided.")
 (depends
  (ocaml
   (>= 4.05))
  cmdliner
  dune
  prelude
  (odoc :with-doc)))
