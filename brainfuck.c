#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <fcntl.h>

char *input(int fd){
    ssize_t size = 4096;
    char *buf = calloc(size, sizeof(char));
    char *tmp = NULL;
    ssize_t n = 0;
    while((n = read(fd, buf, size)) > 0){
        if(n > size){
            size *= 1.5;
            tmp = realloc(buf, size * sizeof(char));
            if(!tmp){
                fprintf(stderr, "brainfuck: %s\n", strerror(errno));
                free(buf);
                exit(1);
            }
        }
    }
    return buf;
}

int main(int argc, char **argv){
    char *data = calloc(30000, sizeof(char));
    char *code = input(open(argv[1], O_RDONLY));
    if(!code){
        fprintf(stderr, "brainfuck: an error occured\n");
    }
    size_t dptr = 0;
    size_t iptr = 0;
    size_t iptr_MAX = strlen(code);

    while(iptr < iptr_MAX){
        int count = 1;
        switch(code[iptr]){
            case '>':
                dptr++;
                break;
            case '<':
                dptr--;
                break;
            case '+':
                data[dptr]++;
                break;
            case '-':
                data[dptr]--;
                break;
            case '.':
                if(write(STDOUT_FILENO, &data[dptr], 1) != 1){
                    fprintf(stderr, "brainfuck: %s\n", strerror(errno));
                    return errno;
                }
                break;
            case ',':
                if(read(STDIN_FILENO, &data[dptr], 1) == -1){
                    fprintf(stderr, "brainfuck: %s\n", strerror(errno));
                    return errno;
                }
                break;
            case '[':
                if(!data[dptr]){
                    iptr++;
                    while(count > 0){
                        if(code[iptr] == '['){
                            count++;
                        }
                        else if(code[iptr] == ']'){
                            count--;
                        }
                        iptr++;
                    }
                    iptr--;
                }
                break;
            case ']':
                if(data[dptr]){
                    iptr--; 
                    while(count > 0){
                        if(code[iptr] == ']'){
                            count++;
                        }
                        else if(code[iptr] == '['){
                            count--;
                        }
                        iptr--;
                    }
                }
                break;
            default:
                break;
        }
        iptr++;
    }
    return 0;
}
