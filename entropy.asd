(defsystem "entropy"
  :description "A library for information theory calculations."
  :author "Quentin Hacourt"
  :version "0.1.0"
  :serial t
  :components ((:file "src/entropy"))
  :in-order-to ((test-op (test-op "entropy/tests-fiveam")
                         (test-op "entropy/tests-parachute"))))

(defsystem "entropy/tests-fiveam"
  :depends-on ("entropy" "fiveam")
  :components ((:file "tests/entropy-test-fiveam"))
  :perform (test-op (o c) (symbol-call :fiveam '#:run! :entropy-suite)))

(defsystem "entropy/tests-parachute"
  :depends-on ("entropy" "parachute")
  :components ((:file "tests/entropy-test-parachute"))
  :perform (test-op (o c) (symbol-call :parachute :test :entropy-test-parachute)))
