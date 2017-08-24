open System

module BrainFuck =

    let rec run (code : string, data : char[], iptr : int, dptr : int, count : int) =
        match code.[iptr] with
        | '>' -> 
            run(code, data, iptr + 1, dptr + 1, count)
        | '<' -> 
            run(code, data, iptr + 1, dptr - 1, count)
        | '+' ->
            Array.set data dptr (char(int(data.[dptr]) + 1))
            run(code, data, iptr + 1, dptr, count)
        | '-' -> 
            Array.set data dptr (char(int(data.[dptr]) - 1))
            run(code, data, iptr + 1, dptr, count)
        | '.' -> 
            printfn "%c" data.[dptr]
            run(code, data, iptr + 1, dptr, count)
        | ',' -> 
            printfn ","
        | '[' -> 
            printfn "["
        | ']' -> 
            printfn "]"
        | _ -> 
            run(code, data, iptr + 1, dptr, count)

[<EntryPoint>]
let main argv = 
    let data : char[] = Array.init 30000 (fun x -> char(0))
    let code : string = System.IO.File.ReadAllText(argv.[0])
    BrainFuck.run(code, data, 0, 1, 1)
    0;
