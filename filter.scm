;; Extrae el último caractér de un string
(define (last-character some-string)
  (car (reverse (string->list some-string))))

;; Corrección del path de entrada (último "/" en el directory-name
(define (valid-dirname dirname)
  (if (equal? (last-character dirname) #\/)
      dirname
      (string-append dirname "/")))

;;;
;;; Dado un determinado directory PATH, retorna la lista de archivos 
;;;
(define (full-path father-path)
  (let ((checked-pathname (valid-dirname father-path)))
    (if (file-exists? checked-pathname)
	(let ((files (cget-files checked-pathname)))
	  (map (lambda (file)
		 (format #t "~a~a\n" checked-pathname file))
	       files))
	(format #t "Error\n"))))

;; Retorna la lista de archivos del directorio, no la imprime
(define (full-path-lst father-path)
  (let ((checked-pathname (valid-dirname father-path)))
    (if (file-exists? checked-pathname)
	(let ((files (cget-files checked-pathname)))
	  files))))

;; Si el archivo tiene extensión (filename.ext)
;; retorna una lista de nombre de archivo y extensión
;; sino retorna sólo el nombre de archivo.
(define (file-extension filename)
  (string-split (basename filename) #\.))

;; El nombre de archivo tiene extensión?, si la longitud de la lista
;; es mayor igual a 2, tiene extensión y retorna true, sino retorna false.
(define (with-file-extension? filename)
  (let ((file-ext (file-extension filename)))
    (if (>= (length file-ext) 2)
	#t
	#f)))

;; second element of the list
(define (second lst)
  (if (>= (length lst) 2)
      (cadr lst)
      '()))

;; La extensión del archivo es "tal" o "cual?"
(define (extension-type? filename extension)
  (if (with-file-extension? filename)
      (if (equal? (second (file-extension filename)) extension)
	  #t
	  #f)
      #f))

;; Filtrar para imprimir según una determinada extensión de archivo
(define (filter-ext directory-path extension)
  (map (lambda (x)
	 (format #t "~a\n" x))
       (filter (lambda (file)
		 (extension-type? file extension))
	       (cget-files directory-path))))

(define (filter-ext-fullpath directory-path extension)
  (map (lambda (x)
	 (format #t "~a~a\n" directory-path x))
       (filter (lambda (file)
		 (extension-type? file extension))
	       (full-path-lst directory-path))))

(format #t "Todos los archivos\n")
(full-path "/home/usuario/books/") ;; ls completo
(newline)
(format #t "Solo archivos con extension PDF\n")
(filter-ext "/home/usuario/books/" "pdf") ;; ls sólo para archivos con extensión "pdf"
(newline)
(format #t "Ruta completa para solo archivos con extension PDF\n")
(filter-ext-fullpath "/home/usuario/books/" "pdf") ;; ls con full path, sólo para archivos con extensión "pdf"
