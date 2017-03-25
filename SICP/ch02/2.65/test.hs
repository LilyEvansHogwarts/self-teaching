import System.Directory
import Control.Monad

isPattern s x = (reverse (take 3 (reverse x))) == s

haha x = renameFile x ("2.65" ++ (drop 4 x))
main = do
   dirName <- getCurrentDirectory
   names <- getDirectoryContents dirName
   mapM haha (filter (isPattern "scm") names)
