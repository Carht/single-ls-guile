;;;
;;; Dado un determinado PATH, retorna la lista interna de archivos 
;;;
(define (full-path father-path)
  (if (file-exists? father-path)
      (let ((files (cget-files father-path)))
	(for-each (lambda (file)
		    (format #t "~a~a" father-path file)
		    (newline))
		  files))
      (format #t "Error")))

(full-path "/home/usuario/")
