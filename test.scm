;; Valida si el directorio de entrada existe.
(define (list-files directory-path)
  (if (file-exists? directory-path)
      (list-dir directory-path)
      (format #t "Error el directorio no existe.")))


;; Extrae el segundo elemento de una lista, si es posible, retorna el elemento
;; sino retorna una lista vacía.
(define (second lst)
  (if (>= (length lst) 2)
      (cadr lst)
      '()))

;; Dada una ruta de directorio y una extensión, retorna la lista de todos
;; los archivos que contengan dicha extensión.
(define (files-with-extension directory-path extension)
  (let ((all-files (list-files directory-path)))
    (map (lambda (filename)
	   (if (equal? (second (string-split (basename filename) #\.)) extension)
	       (format #t "~a\n" filename)))
	 all-files)))

;; Imprime las rutas de los archivos contenidos en el directorio.
(files-with-extension "/home/lisper/books/Lisp/" "pdf")
(files-with-extension "/home/lisper/books/Lisp/" "epub")

