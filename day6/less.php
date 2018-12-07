<?php

function printgrid($grid){
    $size = sizeof($grid);

    for($i = 0; $i < $size; $i++){
        for($j = 0; $j < $size; $j++){ 
            echo $grid[$i][$j];
        }
        echo "\n"; 
    }
}


function manh($x1,$y1,$x2,$y2){ 
    return abs($y2 - $y1) + abs($x2 - $x1);
}


function distsum($grid, $letters, $i, $j){ 
    $dist = 0;

    if($grid[$i][$j] != "."){
        return $grid[$i][$j]; 
    }

    foreach ($letters as $letter => $pos){
    
        $dist += manh($pos[0],$pos[1],$i,$j); 

        if($dist > 10000){
            return ".";
        }
    } 

    return "#"; 
}


#################
# Build Grid 
#################

$size = 500;
$grid = array_fill(0,$size,array_fill(0,$size,'.'));
$letterpos;

$alphas = array_merge(range('A', 'Z'), range('a', 'z'));
$c = 0;


if ($file = fopen("input", "r")) {
    while(!feof($file)) {
        $parts = explode(", ",fgets($file)); 

        if (sizeof($parts) == 2){
            $letter = $alphas[$c++];

            $y = intval($parts[0]);
            $x = intval(trim($parts[1])); 

            $grid[$x][$y] = $letter; 
            $letterpos[$letter] = array($x,$y);
        }
    }
    fclose($file);
}


#################
# Fill grid with nearest
#################


for($i = 0; $i < $size; $i++){
    for($j = 0; $j < $size; $j++){ 
        $grid[$i][$j] = distsum($grid,$letterpos, $i, $j); 
    } 
}


## check if the 8 fields around $x and $y are '#'
function inregion($grid, $x, $y){

    for($i = $x-1; $i < $x+1; $i++){
        for($j = $y-1; $j < $y+1; $j++){ 
            if($grid[$i][$j] == "#"){
                return True;
            }
        } 
    }
    return False;
}


#################
# Counts remaining fields
#################

$count = 0;

for($i = 0; $i < $size; $i++){
    for($j = 0; $j < $size; $j++){ 
        if($grid[$i][$j] == "#"){
            $count++;
        } else if ($grid[$i][$j] != "." and inregion($grid,$i,$j)){
            $count++;
        }
    } 
}


echo $count;

?> 
