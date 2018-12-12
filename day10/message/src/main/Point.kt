package main

data class Point(var position: Pair<Int,Int>, var velocity: Pair<Int,Int>){

    fun move(){
        position = Pair(position.first  + velocity.first, position.second + velocity.second)
    }

}
