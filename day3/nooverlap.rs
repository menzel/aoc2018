use std::fs::File;
use std::io::Read;

fn main(){
    let mut file = File::open("input.txt").expect("opening file");
    let mut text = String::new();
    file.read_to_string(&mut text).expect("reading file");
    const MAX: usize = 1000;

    let mut patches = vec![vec![0u8; MAX]; MAX];

    for line in text.lines(){ 
        setpatch(parseandset(&line, &mut patches),&mut patches); 
    } 

    for line in text.lines(){ 
        setpatchcheck(parseandset(&line, &mut patches),&mut patches); 
    } 
} 

fn parseandset(line : &str, patches: &mut Vec<Vec<u8>>) -> Vec<i32> { 
    let mut result = Vec::new();

    let parts : Vec<&str> = line.split(" ").collect();

    result.push(parts[2].split(",").collect::<Vec<&str>>()[0].parse::<i32>().unwrap());
    let mut tmp = String::from(parts[2].split(",").collect::<Vec<&str>>()[1]);
    tmp.pop();
    result.push(tmp.parse::<i32>().unwrap());
    result.push(parts[3].split("x").collect::<Vec<&str>>()[0].parse::<i32>().unwrap());
    result.push(parts[3].split("x").collect::<Vec<&str>>()[1].parse::<i32>().unwrap());

    return result;
}

fn setpatch(coordinates : Vec<i32>, patches: &mut Vec<Vec<u8>>){
    let x = coordinates[0];
    let y = coordinates[1];
    let w = coordinates[2];
    let h = coordinates[3];

    for xpos in x..(x+w) {
        for ypos in y..(y+h){
            patches[ypos as usize][xpos as usize] += 1;
        } 
    } 
} 

fn setpatchcheck(coordinates : Vec<i32>, patches: &mut Vec<Vec<u8>>){
    //println!("{}{}{}{}",x,y,w,h); 
    let x = coordinates[0];
    let y = coordinates[1];
    let w = coordinates[2];
    let h = coordinates[3];

    for xpos in x..(x+w) {
        for ypos in y..(y+h){
            let mut tmp = patches[ypos as usize][xpos as usize];
            tmp += 1;
            if tmp > 2{
                return
            }
            patches[ypos as usize][xpos as usize] = tmp;
        } 
    } 

    println!("{} {} {} {}",x,y,w,h); 
}
