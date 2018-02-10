#include <string>
#include <fstream>
#include <streambuf>
#include <sstream>
#include <iostream>
#include <stdio.h>

class BrainFuck {
private:
    std::string code;
    size_t iptr = 0;
    size_t dptr = 0;
    char *data = (char*)calloc(30000, sizeof(char));

public:
    BrainFuck(std::string c){
        this->code = c;
    }

    void run(){
        size_t iptr_MAX = this->code.length();

        for(; iptr < iptr_MAX; iptr++){
            size_t count = 1;
            switch(this->code[iptr]){
                case '>':
                    this->dptr++;
                    break;
                case '<':
                    this->dptr--;
                    break;
                case '+':
                    this->data[this->dptr]++;
                    break;
                case '-':
                    this->data[this->dptr]--;
                    break;
                case '.':
                    std::cout << this->data[this->dptr];
                    break;
                case ',':
                    this->data[this->dptr] = (char)getchar();
                    break;
                case '[':
                    if(!this->data[this->dptr]){
                        this->iptr++;
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
                    if(this->data[this->dptr]){
                        this->iptr--;
                        while(count > 0){
                            if(this->code[this->iptr] == ']'){
                                count++;
                            }
                            else if(this->code[this->iptr] == '['){
                                count--;
                            }
                            iptr--;
                        }
                    }
                    break;
                default:
                    break;
            }
        }
    }
};

int main(int argc, char **argv){
    std::ifstream s(argv[1]);
    std::stringstream tmp;
    tmp << s.rdbuf();
    BrainFuck bf = BrainFuck(tmp.str());
    bf.run();
}