(defn bfout [c] (printf (str (char c))))
(defn bfin [] (flush) (byte (nth (read-line) 0)))

(defn bf-run [code iptr data dptr len]
  (when (< iptr len)
    (let [c (nth code iptr)]
      (cond
        (= c \>)(recur code (+ iptr 1) data (+ dptr 1) len)
        (= c \<)(recur code (+ iptr 1) data (- dptr 1) len)
        (= c \+)(recur code (+ iptr 1) (assoc data dptr (+ (nth data dptr nil) 1)) dptr len)
        (= c \-)(recur code (+ iptr 1) (assoc data dptr (- (nth data dptr nil) 1)) dptr len)
        (= c \.)
        (do
          (bfout (nth data dptr nil))
          (recur code (+ iptr 1) data dptr len))
        (= c \,)(recur code (+ iptr 1) (assoc data dptr (bfin)) dptr len)
        :else (recur code (+ iptr 1) data dptr len)))))
      

(def code (slurp "tests/hello.bf"))
(bf-run code 0 (vec (make-array Byte/TYPE 30000)) 0 (count code))
