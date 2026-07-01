(defsystem "entropy"
  :description "A library for information theory calculations."
  :author "Quentin Hacourt"
  :version "0.1.0"
  :serial t
  :components ((:file "src/entropy"))
  :in-order-to ((test-op (test-op "entropy/tests"))))

(defsystem "entropy/tests"
  :depends-on ("entropy" "fiveam")
  :components ((:file "tests/entropy-test-fiveam"))
  :perform (test-op (o c) (symbol-call :fiveam '#:run! :entropy-suite)))
