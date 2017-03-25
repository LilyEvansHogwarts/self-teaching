module RecursiveContents (getRecursiveContents) where

import System.FilePath ((</>))
import Control.Monad (forM)
import System.Directory (getDirectoryContents, doesDirectoryExist)

getRecursiveContents :: FilePath -> IO [FilePath]
getRecursiveContents topdir = do
   names <- getDirectoryContents topdir
   let properNames = filter (`notElem` [".",".."]) names
   paths <- forM properNames $ \name -> do
      let path = topdir </> name
      isDirectory <- doesDirectoryExist path
      if isDirectory
         then getRecursiveContents path
         else return [path]
   return (concat paths)
