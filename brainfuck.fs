open System

module brainfuck =

    type BrainFuck = {
        code : string;
        data : int[];
    }

    let rec retrieve_left (code : string, iptr : int, count : int) =
        if count > 0 then
            if code.[iptr] = ']' then retrieve_left(code, iptr - 1, count + 1)
            elif code.[iptr] = '[' then retrieve_left(code, iptr - 1, count - 1)
            else retrieve_left(code, iptr - 1, count)
        else
            iptr + 1

    let rec retrieve_right (code : string, iptr : int, count : int) =
        if count > 0 then
            if code.[iptr] = '[' then retrieve_right(code, iptr + 1, count + 1)
            elif code.[iptr] = ']' then retrieve_right(code, iptr + 1, count - 1)
            else retrieve_right(code, iptr + 1, count)
        else
            iptr

    let rec run (bf : BrainFuck, iptr : int, dptr : int) =
        if String.length bf.code > iptr then
            match bf.code.[iptr] with
            | '>' -> 
                run(bf, iptr + 1, dptr + 1)
            | '<' -> 
                run(bf, iptr + 1, dptr - 1)
            | '+' ->
                Array.set bf.data dptr (bf.data.[dptr] + 1)
                run(bf, iptr + 1, dptr)
            | '-' -> 
                Array.set bf.data dptr (bf.data.[dptr] - 1)
                run(bf, iptr + 1, dptr)
            | '.' -> 
                printf "%c" (char(bf.data.[dptr]))
                run(bf, iptr + 1, dptr)
            | ',' -> 
                Array.set bf.data dptr (System.Console.Read())
            | '[' -> 
                if bf.data.[dptr] = 0 then run(bf, retrieve_right(bf.code, iptr, 1), dptr)
                else run(bf, iptr + 1, dptr)
            | ']' ->
                if bf.data.[dptr] > 0 then run(bf, retrieve_left(bf.code, iptr - 1, 1), dptr)
                else run(bf, iptr + 1, dptr)
            | _ -> 
                run(bf, iptr + 1, dptr)

[<EntryPoint>]
let main argv = 
    let bf : brainfuck.BrainFuck = {code = System.IO.File.ReadAllText argv.[0]; data = Array.init 30000 (fun x -> 0);}
    brainfuck.run(bf, 0, 0)
    0;
