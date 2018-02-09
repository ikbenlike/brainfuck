const fs = require("fs");
const readline = require("readline");

/*const io = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
});*/

function bf_run(code){
    let iptr = 0;
    let dptr = 0;
    let data = new Array(30000);
    for(var i = 0; i < data.length; i++) data[i] = 0;

    while(iptr < code.length){
        let count = 1;
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
                process.stdout.write(String.fromCharCode(data[dptr]));
                break;
            case ',':
                readline.createInterface({
                    input: process.stdin,
                    output: process.stdout,
                }).question("", (input) => {
                    data[dptr] = input.charCodeAt(0);
                });
                break;
            case '[':
                if(data[dptr] === 0){
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
                if(data[dptr] !== 0){
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
}

bf_run(fs.readFileSync(process.argv[2], "utf8"));