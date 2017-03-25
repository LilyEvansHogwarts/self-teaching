import Data.Time.Clock (UTCTime(..))
import System.Directory (Permissions(..),getModificationTime,getDirectoryContents,getPermissions)
import Control.Exception (handle,IOException,bracket)
import System.IO (IOMode(..),hClose,hFileSize,openFile)
import Control.Monad (forM,liftM)
import System.FilePath ((</>))

data Info = Info {
      infoPath :: FilePath,
      infoPerms :: Maybe Permissions,
      infoSize :: Maybe Integer,
      infoModTime :: Maybe UTCTime
} deriving (Eq,Ord,Show)

getInfo path = do
   perms <- maybeIO (getPermissions path)
   size <- maybeIO (bracket (openFile path ReadMode) hClose hFileSize)
   modified <- maybeIO (getModificationTime path)
   return (Info path perms size modified)

traverse' :: ([Info] -> [Info]) -> FilePath -> IO [Info]
traverse' order path = do
   names <- getUsefulContents path
   contents <- mapM getInfo (path : map (path </>) names)
   liftM concat $ forM (order contents) $ \info -> do
      if isDirectory info && infoPath info /= path
         then traverse' order (infoPath info)
         else return [info]

getUsefulContents path = do
   names <- getDirectoryContents path
   return (filter (`notElem` [".",".."]) names)

isDirectory :: Info -> Bool
isDirectory = maybe False searchable . infoPerms

maybeIO :: IO a -> IO (Maybe a)
maybeIO act = handle ((\_ -> return Nothing) :: IOException -> IO (Maybe a)) (liftM Just act)


