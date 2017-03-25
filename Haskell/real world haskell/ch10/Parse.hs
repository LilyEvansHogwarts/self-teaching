import qualified Data.ByteString.Lazy as L
import qualified Data.ByteString.Lazy.Char8 as L8
import Data.Int

data ParseState = ParseState {
   string :: L.ByteString,
   offset :: Int64
} deriving (Show)

newtype Parse a = Parse {
   runParse :: ParseState -> Either String (a,ParseState)
}

identity :: a -> Parse a
identity a = Parse (\s -> Right (a,s))

--parser equals (identity a) in some extent, get a from (Parse a)
--runParse :: Parse a -> (ParseState -> Either String (a,ParseState))
parse :: Parse a -> L.ByteString -> Either String a
parse parser initState = case runParse parser (ParseState initState 0) of
                            Left err -> Left err
                            Right (result,_) -> Right result

modifyOffset :: ParseState -> Int64 -> ParseState
modifyOffset initState newOffset = initState { offset = newOffset}


parseByte = 
   getState ==> \initState ->
   case L.uncons (string initState) of --L.uncons get the first byte of a ByteString, and return Maybe (byte,rest)
      Nothing -> bail "no more initState"
      Just (byte,remainder) -> putState newState ==> \_ ->
                                  identity byte
                               where newState = initState { string = remainder,offset = newOffset}
                                     newOffset = offset initState + 1

getState :: Parse ParseState
getState = Parse (\s -> Right (s,s))

putState :: ParseState -> Parse ()
putState s = Parse (\_ -> Right ((),s))

bail :: String -> Parse a
bail err = Parse $ \s -> Left $ "byte offset " ++ show (offset s) ++ ": " ++ err

instance Functor Parse where
   fmap f parser = parser ==> \result -> identity (f result)




