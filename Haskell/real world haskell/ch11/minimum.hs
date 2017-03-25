head :: [a] -> a
head [] = error " Prelude.head: empty list"
head (x:_) = x

minimum :: (Ord a) => [a] -> a
minimum [] = error "Prelude.minimum: empty list"
minimum xs = foldl min xs
