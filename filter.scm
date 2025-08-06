;; Extrae el último caractér de un string
(define (last-character some-string)
  (car (reverse (string->list some-string))))

;; Corrección del path de entrada (último "/" en el directory-name
(define (valid-dirname dirname)
  (if (equal? (last-character dirname) #\/)
      dirname
      (string-append dirname "/")))

;;;
;;; Dado un determinado PATH, retorna la lista interna de archivos 
;;;
(define (full-path father-path)
  (let ((checked-pathname (valid-dirname father-path)))
    (if (file-exists? checked-pathname)
	(let ((files (cget-files checked-pathname)))
	  (map (lambda (file)
		 (format #t "~a~a\n" checked-pathname file))
	       files))
	(format #t "Error\n"))))

(full-path "/home/lisper/github/")


