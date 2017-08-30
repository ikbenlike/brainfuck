(defmacro make-byte-array [bytes] 
  `(byte-array [~@(map (fn[v] (list `byte v)) bytes)]))  

(defn bfout [c] (printf (str (char c))))
(defn bfin [] (flush) (byte (nth (read-line) 0)))

(printf (slurp "tests/hello.bf"))
