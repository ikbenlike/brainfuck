import std.file;
import std.stdio;
import std.conv;

struct brainfuck {
    string code;
    byte[30000] data = [0];
    int iptr;
    int dptr;
}

void runbrainfuck(brainfuck bf){
    while(bf.iptr < bf.code.length){
        int count = 1;
        switch(bf.code[bf.iptr]){
            case '>': 
                bf.dptr++;
                break;
            case '<':
                bf.dptr--;
                break;
            case '+':
                bf.data[bf.dptr]++;
                break;
            case '-':
                bf.data[bf.dptr]--;
                break;
            case '.':
                write(to!char(bf.data[bf.dptr]));
                break;
            case ',':
                break;
            case '[':
                if(bf.data[bf.dptr] == 0){
                    bf.iptr++;
                    while(count > 0){
                        if(bf.code[bf.iptr] == '['){
                            count++;
                        }
                        else if(bf.code[bf.iptr] == ']'){
                            count--;
                        }
                        bf.iptr++;
                    }
                    bf.iptr--;
                }
                break;
            case ']':
                if(bf.data[bf.dptr] != 0){
                    bf.iptr--;
                    while(count > 0){
                        if(bf.code[bf.iptr] == ']'){
                            count++;
                        }
                        else if(bf.code[bf.iptr] == '['){
                            count--;
                        }
                        bf.iptr--;
                    }
                }
                break;
            default: break;
        }
        bf.iptr++;
    }
}

int main(string[] argv){
    brainfuck bf;
    bf.code = std.file.readText(argv[1]);
    runbrainfuck(bf);
    return 0;
}
