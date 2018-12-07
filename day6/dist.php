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


function nearest($grid, $letters, $i, $j){ 
    $nletter  = "";
    $dist = PHP_INT_MAX;

    foreach ($letters as $letter => $pos){
    
        $d = manh($pos[0],$pos[1],$i,$j); 

        if($d < $dist){
            $nletter = $letter; 
            $dist = $d;
        } else if ($d == $dist){
            $nletter = "."; 
        }
    } 

    return $nletter; 
}


#################
# Build Grid 
#################

$size = 12;
$grid = array_fill(0,$size,array_fill(0,$size,'.'));
$letterpos;

$alphas = array_merge(range('A', 'Z'), range('a', 'z'));
$c = 0;


if ($file = fopen("small", "r")) {
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


for($i = 1; $i < $size-1; $i++){
    for($j = 1; $j < $size-1; $j++){ 
        $grid[$i][$j] = nearest($grid,$letterpos, $i, $j); 
    } 
}


#################
# Add border rows
#################

$todelete = array();

for($i = 0; $i < $size; $i++){
    for($j = 0; $j < $size; $j++){ 
        if(($i == 0 or $i == $size-1) or ($j == 0 or $j == $size-1)){
            $todelete[nearest($grid,$letterpos, $i, $j)] = null;
        } 
    } 
}

printgrid($grid); 

#################
# Remove letters that are in $todelete
#################

for($i = 0; $i < $size; $i++){
    for($j = 0; $j < $size; $j++){ 
        if(key_exists($grid[$i][$j], $todelete)){
            $grid[$i][$j] = ".";
        } 
    } 
}


#################
# Counts remaining letters
#################


$result = array();

for($i = 0; $i < $size; $i++){
    foreach ((array_count_values($grid[$i])) as $letter => $count){ 
        @($result[$letter] += $count);
    }
}

printgrid($grid); 

asort($result);
print_r($result);

?> 
