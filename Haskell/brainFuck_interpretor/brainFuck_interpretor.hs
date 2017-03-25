import System.IO
import Data.Char

data MoveList = MoveList [Int] Int [Int] deriving (Show,Eq,Read,Ord)

next :: MoveList -> MoveList
next (MoveList as b cs) | cs == [] = (MoveList (as ++ [b]) 0 cs)
                        | otherwise = (MoveList (as ++ [b]) (head cs) (tail cs))

pre :: MoveList -> MoveList
pre (MoveList as b cs) | as == [] = (MoveList as 0 (b:cs))
                       | otherwise = (MoveList (init as) (last as) (b:cs))

count :: Int -> Char -> [Char] -> (Int,[Char])
count p y xss@(x:xs) | y == x = count (p+1) y xs
                     | otherwise = (p,xss)
count p y [] = (p,[])

splitOutLoop p ys (x:xs) | x == '[' = splitOutLoop (p+1) (ys ++ [x]) xs
                         | x == ']' && (p-1) /= 0 = splitOutLoop (p-1) (ys ++ [x]) xs
                         | x == ']' && (p-1) == 0 = [ys,xs]
                         | otherwise = splitOutLoop p (ys ++ [x]) xs
    

brainFuck_loop_interpretor [xs1,xs2] (MoveList as b cs) | b == 0 = brainFuck_interpretor xs2 (MoveList as b cs)
                                                        | otherwise = do newMoveList <- brainFuck_interpretor xs1 (MoveList as b cs)
                                                                         brainFuck_loop_interpretor [xs1,xs2] newMoveList 
--                                                        | otherwise = brainFuck_loop_interpretor [xs1,xs2] newMoveList 
--                                                              where newMoveList = brainFuck_interpretor xs1 (MoveList as b cs)
putCase xs (MoveList as b cs) = do putChar $ chr b
                                   brainFuck_interpretor xs (MoveList as b cs)

getCase xs (MoveList as b cs) = do k <- getChar
                                   brainFuck_interpretor xs (MoveList as (ord k) cs)
                                
brainFuck_interpretor [] (MoveList as b cs) = return $ (MoveList as b cs) 
brainFuck_interpretor (x:xs) (MoveList as b cs) = 
    case x of 
       '>' -> brainFuck_interpretor xs (next (MoveList as b cs))
       '<' -> brainFuck_interpretor xs (pre (MoveList as b cs))
       '+' -> brainFuck_interpretor xs (MoveList as (b+1) cs)
       '-' -> brainFuck_interpretor xs (MoveList as (b-1) cs)
       '[' -> brainFuck_loop_interpretor (splitOutLoop 1 [] xs) (MoveList as b cs)
       '.' -> putCase xs (MoveList as b cs)
       ',' -> getCase xs (MoveList as b cs)
       otherwise -> brainFuck_interpretor xs (MoveList as b cs)

main = do
   inh <- openFile "test.bf" ReadMode
   inpStr <- hGetContents inh
   (MoveList as b cs) <- brainFuck_interpretor inpStr (MoveList [] 0 []) 
   let xs = as ++ [b] ++ cs
   putStrLn $ show xs
   hClose inh
