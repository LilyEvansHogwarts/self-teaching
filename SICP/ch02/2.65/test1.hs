import System.Directory
import Control.Monad
import System.IO
import Data.List
isPattern s x = (reverse (take 3 (reverse x))) == s

haha x = "(load \"" ++ x ++ "\")\n"

main = do
   dirName <- getCurrentDirectory
   names <- getDirectoryContents dirName
   let load_obj = concat (map haha (filter (isPattern "scm") names))
   writeFile "2.65-test.scm" load_obj
