(ql:quickload '("spinneret" "clack" "alexandria" "optima"))

(in-package #:spinneret)

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
   `(with-html
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
  (destructuring-bind (&key request-method path-info request-uri
                            query-string headers &allow-other-keys)
      env
    `(200
      nil
      (,(format nil "Method: ~S Path: ~S URI: ~A Query: ~S~%Headers: ~S"
                request-method path-info request-uri query-string
                (alexandria:hash-table-alist headers))))))

(defvar *handler*
    (clack:clackup
      (lambda (env)
        (funcall 'handler env))))

