(use-modules (ice-9 pretty-print))

(define all-files
  (list-dir "/home/lisper/github/single-ls-guile/"))
(pretty-print all-files)
(display (length all-files))
(display " rutas encontradas\n")
