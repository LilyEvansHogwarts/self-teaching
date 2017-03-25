import qualified Data.ByteString.Lazy.Char8 as L

closing :: L.ByteString -> Maybe Int
closing = readPrice . (!!4) . L.split ','

readPrice :: L.ByteString -> Maybe Int
readPrice str = case L.readInt str of
                   Nothing -> Nothing
                   Just (dollars, rest) -> case L.readInt (L.tail rest) of
                                              Nothing -> Nothing
                                              Just (cents, more) -> Just (dollars * 100 + cents)

highestClose :: L.ByteString -> Maybe Int
highestClose contents = maximum . (Nothing:) . map closing $ L.lines contents 

highestCloseFrom :: FilePath -> IO ()
highestCloseFrom name = do contents <- L.readFile name
                           print $ highestClose contents
