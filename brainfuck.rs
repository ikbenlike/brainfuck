use std::fs::File;
use std::env;
use std::io::Read;

struct BrainFuck {
    code : String,
    data : [u8; 30000]
}

fn read_string(path : String) -> String {
    use std::io::prelude::*;
    let mut file = File::open(path).expect("No such file!");
    let mut contents = String::new();
    file.read_to_string(&mut contents).expect("Failed to read file");
    return contents;
}

fn run(mut bf : BrainFuck) -> () {
    let mut iptr : usize = 0;
    let mut dptr : usize = 0;
    let len = bf.code.len();

    while iptr < len {
        let mut count : usize = 1;
        if let Some(c) = bf.code.chars().nth(iptr) {
            match c {
                '>' => dptr += 1,
                '<' => dptr -= 1,
                '+' => bf.data[dptr] += 1,
                '-' => bf.data[dptr] -= 1,
                '.' => print!("{}", bf.data[dptr] as char),
                ',' => bf.data[dptr] = std::io::stdin().bytes().next().unwrap().unwrap(), 
                '[' =>
                    if bf.data[dptr] == 0 {
                        iptr += 1;
                        while count > 0 {
                            if bf.code.chars().nth(iptr) == Some('[') {
                                count += 1;
                            }
                            else if bf.code.chars().nth(iptr) == Some(']') {
                                count -= 1;
                            }
                            iptr += 1
                        }
                        iptr -= 1
                    },
                ']' => 
                    if bf.data[dptr] != 0 {
                        iptr -= 1;
                        while count > 0 {
                            if bf.code.chars().nth(iptr) == Some(']') {
                                count += 1;
                            }
                            else if bf.code.chars().nth(iptr) == Some('[') {
                                count -= 1;
                            }
                            iptr -= 1;
                        }
                    },
                _ => () 
            }
        }
        iptr += 1
    }
}

fn main() {
   let argv : Vec<String> = env::args().collect();
   let bf = BrainFuck{code : read_string((&argv[1]).to_string()), data : [0; 30000]};

   run(bf);
}
