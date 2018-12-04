use std::fs::File;
use std::io::Read;

fn main(){
    let mut file = File::open("input.txt").expect("opening file");
    let mut text = String::new();
    file.read_to_string(&mut text).expect("reading file");
    const MAX: usize = 1000;

    let mut patches = vec![vec![0u8; MAX]; MAX];

    for line in text.lines() {
        let mut parts : Vec<&str> = line.split(" ").collect();

        //println!("{:?}", parts); 

        let mut x = parts[2].split(",").collect::<Vec<&str>>()[0].parse::<i32>().unwrap();
        let mut tmp = String::from(parts[2].split(",").collect::<Vec<&str>>()[1]);
        tmp.pop(); //removes the ';' from the input
        let y = tmp.parse::<i32>().unwrap();
        let mut w = parts[3].split("x").collect::<Vec<&str>>()[0].parse::<i32>().unwrap();
        let mut h = parts[3].split("x").collect::<Vec<&str>>()[1].parse::<i32>().unwrap();

        setpatch(x,y,w,h,&mut patches); 
    } 

    let mut count = 0i32;

    for i in 0..MAX { 
        for j in 0..MAX { 
            //println!("{:?}", patches[i]) 
            if patches[i][j] > 1{
                count += 1;
            }
        }
    }
    println!("{}",count);
} 

fn setpatch(x : i32, y : i32, w : i32, h : i32, patches: &mut Vec<Vec<u8>>){
    //println!("{}{}{}{}",x,y,w,h); 

    for xpos in x..(x+w) {
        for ypos in y..(y+h){
            patches[ypos as usize][xpos as usize] += 1;
        } 
    } 
} 
