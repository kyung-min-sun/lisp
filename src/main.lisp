(ql:quickload '("clack"
               "alexandria"
               "optima"
               "spinneret"))

(use-package :spinneret)
(use-package :optima)

(defparameter *shopping-list*
   '("Atmospheric ponds"
     "Electric gumption socks"
     "Mrs. Leland's embyronic television combustion"
     "Savage gymnatic aggressors"
     "Pharmaceutical pianos"
     "Intravenous retribution champions"))

(defparameter *user-name* "John Q. Lisper")

(defparameter *last-login* "12th Never")


(defmacro with-page ((&key title) &body body)
   `(with-html-string
      (:doctype)
      (:html
        (:head
         (:title ,title))
        (:body ,@body))))

(defun shopping-list ()
   (with-page (:title "Home page")
     (:header
      (:h1 "Home page"))
     (:section
      ("~A, here is *your* shopping list: " *user-name*)
      (:ol (dolist (item *shopping-list*)
             (:li (1+ (random 10)) item))))
     (:footer ("Last login: ~A" *last-login*))))

(defun handler (env)
  (optima:match env 
    ((guard (property :path-info path)
            (alexandria:starts-with-subseq "/foo" path))
      `(200 nil (,(format nil "The path ~A is in /foo~%" path))))))

(clack:clackup
  (lambda (env)
    (funcall 'handler env))
  :port 3000)

