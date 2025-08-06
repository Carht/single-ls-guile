(define files (cget-files "/home/usuario/"))

(for-each (lambda (f)
	    (format #t "~a" f)
	    (newline))
	  files)
