fun aset a s i = (Array.update(a, s, i); a)

fun read_all name =
    let
        val strm = TextIO.openIn name
        val text = TextIO.inputAll strm
    in
        TextIO.closeIn strm;
        text ^ ""
    end

fun retrieve_left code iptr 0 = iptr + 1
  | retrieve_left code iptr count =
    (case (String.sub(code, iptr)) of
          #"]" => retrieve_left code (iptr - 1) (count + 1)
        | #"[" => retrieve_left code (iptr - 1) (count - 1)
        | _    => retrieve_left code (iptr - 1) count)

fun retrieve_right code iptr 0 = iptr
  | retrieve_right code iptr count =
    (case (String.sub(code, iptr)) of
          #"[" => retrieve_right code (iptr + 1) (count + 1)
        | #"]" => retrieve_right code (iptr + 1) (count - 1)
        | _    => retrieve_right code (iptr + 1) count)

fun run code data iptr dptr =
    if String.size code > iptr then
        case String.sub(code, iptr) of
             #">" => run code data (iptr + 1) (dptr + 1)
           | #"<" => run code data (iptr + 1) (dptr - 1)
           | #"+" => run code (aset data dptr (Array.sub(data, dptr) + 1)) (iptr + 1) dptr
           | #"-" => run code (aset data dptr (Array.sub(data, dptr) - 1)) (iptr + 1) dptr
           | #"." => (print (String.str (Char.chr (Array.sub(data, dptr)))); run code data (iptr + 1) dptr)
           | #"," => run code (aset data dptr (Char.ord (String.sub(TextIO.inputN(TextIO.stdIn, 1), 0)))) (iptr + 1) dptr
           | #"[" => if Array.sub(data, dptr) = 0 then
                        run code data (retrieve_right code iptr 1) dptr
                     else
                        run code data (iptr + 1) dptr
           | #"]" => if Array.sub(data, dptr) > 0 then
                        run code data (retrieve_left code (iptr - 1) 1) dptr
                     else
                        run code data (iptr + 1) dptr
           | _    => run code data (iptr + 1) dptr
    else OS.Process.exit OS.Process.success;

run (read_all (List.nth(CommandLine.arguments(), 0))) (Array.array(30000,0)) 0 0;