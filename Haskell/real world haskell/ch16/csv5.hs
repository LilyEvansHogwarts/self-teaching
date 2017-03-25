import Text.ParserCombinators.Parsec

eol :: Parser Char
eol = do char '\n'
         option '\n' (char '\r')
