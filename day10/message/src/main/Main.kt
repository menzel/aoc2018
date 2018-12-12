package main

import java.io.File
import java.io.InputStream
import java.util.*

const val gridsize = 52554 + 52096 + 1000
const val offset = 50000

fun main(args : Array<String>) {

    val inputStream: InputStream = File("../input").inputStream()
    val points = mutableListOf<Point>()

    inputStream.bufferedReader().useLines { lines -> lines.forEach {

        val parts = it.split("[<,>]".toRegex())
        if (parts[4].toInt() == 0 && parts[5].toInt() == 0)
            error("stationary point")

        points.add(Point(Pair(parts[2].toInt() + offset, parts[1].toInt() + offset), Pair(parts[5].toInt(), parts[4].toInt())))
    }}

    points.sortWith(compareBy {it.position.first})

    for (i in  0..30000){

        val n = freelines(points)

        // count free lines above the points and below, if there are below 20 lines with particles print grid
        if (gridsize - n < 20){
            println("Seconds $i")
            printgrid(getgrid(points))
        }

        points.onEach(Point::move)
        points.sortWith(compareBy {it.position.first})
    }
}

fun freelines(points: MutableList<Point>): Int {

    return points[0].position.first + (gridsize - points.last().position.first)
}

fun getgrid(points: List<Point>): List<List<Char>> {
    val ret : MutableList<MutableList<Char>> = mutableListOf()

    for(i in  points[0].position.first .. points.last().position.first +1){
        ret.add(Collections.nCopies(gridsize, '.').toMutableList())
    }

    for(point in points)
        ret[point.position.first - points[0].position.first][point.position.second] = '#'

    return ret
}

fun printgrid(grid: List<List<Char>>) {

    for (i in 0 until grid.size) {
        var start = false
        var c  = 0
        for (j in 0 until grid.first().size) {

            if(grid[i][j] == '#') start = true
            if (start){
                print(grid[i][j])
                c++
            }
            if ( c > 200) break
        }
        println()
    }
}
