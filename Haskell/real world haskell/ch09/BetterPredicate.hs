import RecursiveContents (getRecursiveContents)
import System.Time (ClockTime(..))
import Control.Exception (bracket,handle,IOException)
import System.FilePath (takeExtension)
import System.Directory (Permissions(..), getModificationTime,getPermissions)
import Control.Monad (filterM)
import System.IO (IOMode(..),hClose,hFileSize,openFile)

type Predicate = FilePath            --path to directory entry 
              -> Permissions         --permissions
              -> Maybe Integer       --file size (Nothing if not file)
              -> ClockTime           --last modified
              -> Bool

betterFind p path = getRecursiveContents path >>= filterM check
   where check name = do
            perms <- getPermissions name
            size <- getFileSize name
            modified <- getModificationTime name
            return (p name perms size modified)

simpleFileSize path = do
   h <- openFile path ReadMode
   size <- hFileSize h
   hClose h
   return size

saferFileSize path = handle ((\_ -> return Nothing) :: IOException -> IO (Maybe Integer)) $ do
   h <- openFile path ReadMode
   size <- hFileSize h
   hClose h
   return (Just size)

getFileSize path = handle ((\_ -> return Nothing) :: IOException -> IO (Maybe Integer))$
   bracket (openFile path ReadMode) hClose $ \h -> do
      size <- hFileSize h
      return (Just size)

myTest path _ (Just size) _ = takeExtension path == ".cpp" && size > 131072
myTest _ _ _ _ = False

type InfoP a = FilePath
            -> Permissions
            -> Maybe Integer
            -> ClockTime
            -> a

pathP :: InfoP FilePath
pathP path _ _ _ = path

sizeP :: InfoP Integer
sizeP _ _ (Just size) _ = size
sizeP _ _ Nothing _ = -1

equalP :: (Eq a) => InfoP a -> a -> InfoP Bool --return a function
equalP f k = \w x y z -> f w x y z == k

liftP :: (a -> b -> c) -> InfoP a -> b -> InfoP c
liftP comparator getter argument w x y z = (getter w x y z) `comparator` argument

greaterP,lesserP :: (Ord a) => InfoP a -> a -> InfoP Bool
greaterP = liftP (>)
lesserP = liftP (<)

simpleAndP :: InfoP Bool -> InfoP Bool -> InfoP Bool
simpleAndP f g = \w x y z -> f w x y z && g w x y z

liftP2 :: (a -> b -> c) -> InfoP a -> InfoP b -> InfoP c
liftP2 q f g = \w x y z -> (f w x y z) `q` (g w x y z)

andP = liftP2 (&&)

orP = liftP2 (||)

liftPath f w _ _ _ = f w

myTest2 = (liftPath takeExtension `equalP` ".cpp") `andP` (sizeP `greaterP` 131072)

(==?) = equalP
(&&?) = andP
(>?) = greaterP

myTest3 = (liftPath takeExtension ==? ".cpp") &&? (sizeP >? 131072)

infix 4 ==?
infixr 3 &&?
infix 4 >?

myTest4 = liftPath takeExtension ==? ".cpp" &&? sizeP >? 131072

