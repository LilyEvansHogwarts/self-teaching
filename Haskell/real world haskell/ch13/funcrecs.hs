data CustomColor = CustomColor { red :: Int,green :: Int,blue :: Int } deriving (Eq,Show,Read)

data FuncRec = 
   FuncRec { name :: String,
             calc :: Int -> Int,
             namedCalc :: Int -> (String,Int)
           }

plus5func :: CustomColor -> Int -> (CustomColor,Int)
plus5func color x = (color, x + 5)

purple = CustomColor 255 0 255

mkFuncRec :: String -> (Int -> Int) -> FuncRec
mkFuncRec name calcfunc = FuncRec {name = name, calc = calcfunc, namedCalc = \x -> (name, calcfunc x)}

plus5 = mkFuncRec "plus5" (+5)
always0 = mkFuncRec "always0" (\_ -> 0)

