(defn bfout [c] (printf (str (char c))))
(defn bfin [] (flush) (byte (nth (read-line) 0)))

(defn retrieve-left [code ind amount]
    (if (= amount 0)
        (+ ind 1)
        (let [c (nth code (- ind 1))]
            (if (= c \[)
                (recur code (- ind 1)(- amount 1))
                (if (= c \])
                    (recur code (- ind 1)(+ amount 1))
                    (recur code (- ind 1) amount))))))

(defn retrieve-right [code ind amount]
    (if (= amount 0)
        ind
        (let [c (nth code (+ ind 1))]
            (if (= c \])
                (recur code (+ ind 1)(- amount 1))
                (if (= c \[)
                    (recur code (+ ind 1)(+ amount 1))
                    (recur code (+ ind 1) amount))))))

(defn bf-run [code iptr data dptr len]
  (when (< iptr len)
    (let [c (nth code iptr)]
      (cond
        (= c \>)
            (recur code (+ iptr 1) data (+ dptr 1) len)
        (= c \<)
            (recur code (+ iptr 1) data (- dptr 1) len)
        (= c \+)
            (recur code (+ iptr 1) (assoc data dptr (+ (nth data dptr nil) 1)) dptr len)
        (= c \-)
            (recur code (+ iptr 1) (assoc data dptr (- (nth data dptr nil) 1)) dptr len)
        (= c \.)
            (do
              (bfout (nth data dptr nil))
              (recur code (+ iptr 1) data dptr len))
        (= c \,)(recur code (+ iptr 1) (assoc data dptr (bfin)) dptr len)
        (= c \[)
            (if (= (nth data dptr) 0)
                (recur code (retrieve-right code iptr 1) data dptr len)
                (recur code (+ iptr 1) data dptr len))
        (= c \])
            (if (not= (nth data dptr) 0)
                (recur code (retrieve-left code (- iptr 1) 1) data dptr len)
                (recur code (+ iptr 1) data dptr len))
        :else (recur code (+ iptr 1) data dptr len)))))
  
(def code (slurp "tests/helloworld.bf"))
(bf-run code 0 (vec (make-array Integer/TYPE 30000)) 0 (count code))
