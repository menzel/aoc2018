import Prelude hiding (replicate)
import Data.Vector hiding ((!), mapM_, take)
import qualified Data.Vector as V ((!?))
import Data.Monoid
 
type Cell = Char
type Universe = Vector Cell
 

on, off :: Cell
on = '#'
off = '.'

start :: Universe 

start = replicate 20 off <> fromList [on,on,off,off,off,off,on,off,on,off,on,off,off,off,on,off,on,off,off,on,off,on,on,on,on,on,off,on,off,on,off,on,on,off,on,off,on,off,on,on,on,on,on,on,on,off,off,off,on,off,on,on,off,off,off,off,on,off,off,on,on,off,off,off,off,on,off,on,off,off,on,on,off,on,on,on,on,off,on,off,off,off,off,off,off,off,off,off,off,on,off,off,on,off,off,off,on] <> replicate 20 off


-- example case, should produce 325
-- start = replicate 10 off <>  fromList [on,off,off,on,off,on,off,off,on,on,off,off,off,off,off,off,on,on,on,off,off,off,on,on,on] <> replicate 10 off

  
(!) :: Universe -> Int -> Cell
v ! i = maybe off id (v V.!? i)
 
neighbors :: Universe -> Int -> Cell -> [Cell]
neighbors v i _ = fmap (v!) [i-2..i+2]
 
next :: Universe -> Universe
next v = fmap rule $ imap (neighbors v) v
 
rule :: [Cell] -> Cell

rule "..#.#" = on
rule ".####" = on
rule "#...." = off
rule "####." = on
rule "...##" = off
rule ".#.#." = off
rule "..#.." = off
rule "##.#." = off
rule "#.#.#" = on
rule "....." = off
rule "#.#.." = off
rule "....#" = off
rule ".#..#" = off
rule "###.#" = on
rule "#..#." = off
rule "#####" = off
rule "...#." = on
rule "#.##." = on
rule ".#.##" = on
rule "#..##" = on
rule ".##.." = on
rule "##.##" = off
rule "..###" = off
rule "###.." = off
rule "##..#" = on
rule ".#..." = on
rule ".###." = on
rule "#.###" = off
rule ".##.#" = off
rule "#...#" = on
rule "##..." = off
rule "..##." = off

main :: IO ()

laststate = Prelude.head . Prelude.reverse .  take 21 . fmap toList $ iterate next start

main = do 
    let result = Prelude.foldr (+) 0 [x-20 | x <- [0..Prelude.length laststate - 1], laststate !! x == on]
    print result








