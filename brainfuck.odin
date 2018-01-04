import "core:os.odin"
import "core:fmt.odin"

main :: proc(){
    code, ok := os.read_entire_file(os.args[1]);
    if !ok {
        fmt.printf("Couldn't open file %s", os.args[1]);
        return;
    }

    data := make([]u8, 30000);
    defer free(data);
    defer free(code);
    iptr := 0;
    dptr := 0;
    iptr_MAX := len(code);

    for ; iptr < iptr_MAX; iptr += 1 {
        count := 1;
        switch code[iptr] {
            case '>':
                dptr += 1;
                break;
            case '<':
                dptr -= 1;
                break;
            case '+':
                data[dptr] += 1;
                break;
            case '-':
                data[dptr] -= 1;
                break;
            case '.':
                fmt.fprintf(os.stdout, "%c", data[dptr]);
                break;
            case ',':
                os.read(os.stdin, &data[dptr], 1);
                break;
            case '[':
                if data[dptr] == 0 {
                    iptr += 1;
                    for count > 0 {
                        if code[iptr] == '[' {
                            count += 1;
                        }
                        else if code[iptr] == ']'{
                            count -= 1;
                        }
                        iptr += 1;
                    }
                    iptr -= 1;
                }
                break;
            case ']':
                if data[dptr] != 0 {
                    iptr -= 1;
                    for count > 0 {
                        if code[iptr] == ']' {
                            count += 1;
                        }
                        else if code[iptr] == '[' {
                            count -= 1;
                        }
                        iptr -= 1;
                    }
                }
                break;
        }
        //iptr += 1;
    }
}