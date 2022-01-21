(defsystem "alexandria-tests"
  :licence "Public Domain / 0-clause MIT"
  :description "Tests for Alexandria, which is a collection of portable public domain utilities."
  :author "Nikodemus Siivola <nikodemus@sb-studio.net>, and others."
  :depends-on (:alexandria #+sbcl :sb-rt #-sbcl :rt)
  :components ((:file "alexandria-1/tests")
               (:file "alexandria-2/tests"))
  :perform (test-op (o c)
             (let ((unexpected-failure-p nil))
               (flet ((run-tests (&rest args)
                        (unless (apply (intern (string '#:run-tests) '#:alexandria-tests) args)
                          (setf unexpected-failure-p t))))
                 (run-tests :compiled nil)
                 (run-tests :compiled t))
               (when unexpected-failure-p
                 (error "Unexpected test failure")))))
