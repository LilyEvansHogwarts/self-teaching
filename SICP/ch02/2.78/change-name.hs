import System.Directory
import Control.Monad

isPattern x = (reverse (takeWhile not_dot (reverse x))) == "scm"
   where not_dot s = (s /= '.')

change_name x = renameFile x newName
   where newName = "2.78" ++ (dropWhile not_hyphen x)
         not_hyphen s = (s /= '-')

main = do
   dirName <- getCurrentDirectory
   names <- getDirectoryContents dirName
   mapM change_name (filter isPattern names)
