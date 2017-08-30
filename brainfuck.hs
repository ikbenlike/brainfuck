import Data.Array

retrieve_left :: String -> Int -> Int -> Int
retrieve_left code iptr 0 = iptr
retrieve_left code iptr count
    | c == ']' = retrieve_left code (iptr - 1) (count + 1)
    | c == '[' = retrieve_left code (iptr - 1) (count - 1)
    | otherwise = retrieve_left code (iptr - 1) count
    where c = code !! iptr

retrieve_right :: String -> Int -> Int -> Int
retrieve_right code iptr 0 = iptr + 1
retrieve_right code iptr count
    | c == '[' = retrieve_right code (iptr + 1) (count + 1)
    | c == ']' = retrieve_right code (iptr + 1) (count - 1)
    | otherwise = retrieve_right code (iptr + 1) count
    where c = code !! iptr

run_bf :: String -> String -> Int -> Int -> ()
run_bf code bdata iptr dptr
    | c == '>' = run_bf code bdata iptr (dptr + 1)
    | c == '<' = run_bf code bdata iptr (dptr - 1)
    | c == '+' = run_bf code bdata iptr dptr
    | otherwise = run_bf code bdata (iptr + 1) dptr
    where c = code !! iptr

main = print ("Hello, World!")
