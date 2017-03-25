data Doc = Empty
         | Char Char
         | Text String
         | Line
         | Concat Doc Doc
         | Union Doc Doc
         deriving (Show,Eq)

fold :: (Doc -> Doc -> Doc) -> [Doc] -> Doc
fold f = foldr f empty


