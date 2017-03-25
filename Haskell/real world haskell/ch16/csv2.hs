import Text.ParserCombinators.Parsec

csvFile = endBy line (char '\n')
line = sepBy cell (char ',')
cell = many (noneOf ",\n")

parseCSV :: String -> Either ParseError [[String]]
parseCSV input = parse csvFile "(unknown)" input
