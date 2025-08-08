(use-modules (ice-9 pretty-print))

(define lst (list-dir "/home/usuario/src/single-ls-guile/"))
(pretty-print lst)
(display (length lst)) (display " rutas encontradas\n")
