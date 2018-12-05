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

; From https://rosettacode.org/wiki/Generate_lower_case_ASCII_alphabet#Common_Lisp 
(defvar *lower*
  (loop with a = (char-code #\a)
        for i below 26
        collect (code-char (+ a i))))


(let ((in (open "full")))
    (setq *polymer* (read-line in))
(close in))

(loop for letter in *lower* do
  (print letter)
  (print (length (reac (remove (char(string-upcase letter) 0) (remove letter *polymer* ))))))
