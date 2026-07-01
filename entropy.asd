(defsystem "entropy"
  :description "A library for information theory calculations."
  :author "Quentin Hacourt"
  :version "0.1.0"
  :serial t
  :components ((:file "src/entropy")))

(defsystem "entropy/tests-fiveam"
  :depends-on ("entropy" "fiveam")
  :components ((:file "tests/entropy-test-fiveam")))

(defsystem "entropy/tests-parachute"
  :depends-on ("entropy" "parachute")
  :components ((:file "tests/entropy-test-parachute")))

(defsystem "entropy/tests-lisp-unit2"
  :depends-on ("entropy" "lisp-unit2")
  :components ((:file "tests/entropy-test-lisp-unit2")))

(defsystem "entropy/tests"
  :depends-on ("entropy/tests-fiveam"
               "entropy/tests-parachute"
               "entropy/tests-lisp-unit2")
  :perform (test-op (o c)
                    (symbol-call :fiveam '#:run! :entropy-suite)
                    (symbol-call :parachute :test :entropy-test-parachute)
                    (symbol-call :lisp-unit2 '#:print-summary
                                 (symbol-call :lisp-unit2 '#:run-tests
                                              :package :entropy-test-lisp-unit2))))
