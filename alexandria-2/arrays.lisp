(in-package :alexandria-2)

(defun dim-in-bounds-p (dimensions &rest subscripts)
  "Mirrors cl:array-in-bounds-p, but takes dimensions (list of integers) as its
   first argument instead of an array.
   (array-in-bounds-p arr ...) == (dim-in-bounds-p (array-dimensions arr) ...)"
  (and (= (length dimensions) (length subscripts))
       (every (lambda (i d) (and (integerp i) (< -1 i d)))
              subscripts dimensions)))

(defun row-major-index (dimensions &rest subscripts)
  "Mirrors cl:array-row-major-index, but takes dimensions (list of integers)
   as its first argument instead of an array.
   Signals an error if lengths of dimensions and subscripts are not equal
   (array-row-major-index arr ...) == (row-major-index (array-dimensions arr) ...)"
  (unless (apply #'dim-in-bounds-p dimensions subscripts)
    (error (format nil "Indices ~a invalid for dimensions ~a" subscripts dimensions)))
  (loop with word-idx = 0
        with dimprod = 1
        for dim-size in (reverse dimensions)
        for dim-idx in (reverse subscripts)
        do
           (incf word-idx (* dim-idx dimprod))
           (setf dimprod (* dimprod dim-size))
        finally (return word-idx)))
