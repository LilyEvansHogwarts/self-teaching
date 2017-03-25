import Data.List
import System.IO
import Control.Monad (when)
import System.Exit
import System.Environment (getArgs)

findByUID :: String -> Int -> Maybe String
findByUID content uid = 
   let al = map parseline $ lines content
      in lookup uid al

parseline input =
   let fields = split ':' input
      in (read (fields !! 2)::Int,fields !! 0)

split x str = do
   let xs = takeWhile (/= x) str
       ys = dropWhile (/= x) str
      in xs : case ys of
                 [] -> []
                 _ -> split x $ tail ys

main = do
   args <- getArgs
   when (length args /= 2) $ do
      putStrLn "Syntax: passwd-al filename uid"
      exitFailure
   content <- readFile (args!!0)
   let username = findByUID content (read (args!!1)::Int)
   case username of 
      Just x -> putStrLn x
      Nothing -> putStrLn "Could not find the UID"


