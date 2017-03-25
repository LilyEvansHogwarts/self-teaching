IMP ys xs = case xs of 
               ' ':xss -> stack ys xss
               '\t':' ':xss -> arithmetic ys xss
               '\t':'\t':xss -> heap ys xss
               '\n':xss -> flow ys xss
               '\t':'\n':xss -> IO_com ys xss

stack yss@(y1:y2:ys) xs = case xs of
              ' ':xss -> do (n,xss) <- number 0 xss
                            IMP (n:yss) xss
              '\n':' ':xss -> IMP (y1 : yss) xss
              '\t':' ':xss -> IMP ((!!(n-1)) yss : yss) xss
              '\n':'\t':xss -> IMP (y2:y1:ys) xss
              '\n':'\n':xss -> IMP (y2:ys) xss
              '\t':'\n':xss -> do --what does this step do

number acc (x:xs) | x == ' ' = number (acc * 2) xs
                  | x == '\t' = number (acc * 2 + 1) xs
                  | x == '\n' = return (acc,xs)

flow ys xs = 

IO_com ys (x1:x2:xs) | x1 == ' ' && x2 == ' ' = do putChar $ head ys
                                                   IMP ys xs
                     | x1 == ' ' && x2 == '\t' = do print $ head ys
                                                    IMP ys xs
                     | x1 == '\t' && x2 == ' ' = do a <- getChar
                                                    IMP (a:ys) xs
                     | x1 == '\t' && x2 == '\t' = do a <- getLine 
                                                     IMP ((read a :: Int) : ys) xs

arithmetic (y1:y2:ys) xs = case xs of 
                              ' ':' ':xss -> IMP ((y1+y2):ys) xss
                              ' ':'\t':xss -> IMP ((y1-y2):ys) xss
                              ' ':'\n':xss -> IMP ((y1*y2):ys) xss
                              '\t':' ':xss -> IMP ((div y1 y2):ys) xss
                              '\t':'\t':xss -> IMP ((mod y1 y2):ys) xss

