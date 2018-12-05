(defun doesreact (s) 
    (and (string= (string-downcase (subseq s 0 1)) (string-downcase (subseq s 1 2))) (not (string= (subseq s 0 1) (subseq s 1 2)))))

(defun reac (s)
  (loop for i from 0 below (- (length s) 1) do
    (if (doesreact (subseq s i (+ i 2)))
        (return-from reac (reac
          (concatenate 'string
           (subseq s 0 i) 
            (subseq s (+ i 2) (length s)))))))
  (return-from reac s))

  

(let ((in (open "input")))
  (print (length (reac (read-line in))))
 (close in))
