import RecursiveContents (getRecursiveContents)

simpleFind p path = do
   names <- getRecursiveContents path 
   return (filter p names)
