import System.Directory
import Control.Monad
import System.IO
isPattern s x = (reverse (take (length s) (reverse x))) == s


haha x = renameFile x ("2.57" ++ (drop 4 x))
                     
main = do
   dirName <- getCurrentDirectory
   putStrLn $ show dirName
   names <- getDirectoryContents dirName
   putStrLn $ show names
   let names' = filter (isPattern ".scm") names
   putStrLn $ show names'
   mapM haha (filter (isPattern ".scm") names)
