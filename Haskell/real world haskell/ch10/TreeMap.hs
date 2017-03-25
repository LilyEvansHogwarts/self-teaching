{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverlappingInstances #-}

data Tree a = Node (Tree a) (Tree a) | Leaf a deriving (Show)


treeLengths (Leaf s) = Leaf (length s)
treeLengths (Node l r) = Node (treeLengths l) (treeLengths r)

treeMap :: (a -> b) -> Tree a -> Tree b
treeMap f (Leaf a) = Leaf (f a)
treeMap f (Node l r) = Node (treeMap f l) (treeMap f r)

instance Functor Tree where
   fmap = treeMap

data OrdStack a = Bottom | Item a (OrdStack a) deriving (Eq,Show)

isIncrease (Item a rest@(Item b _))
   | a > b = isIncrease rest
   | otherwise = False
isIncrease _ = True

push :: (Ord a) => a -> OrdStack a -> OrdStack a
push a s = Item a s

instance Functor (Either Int) where
   fmap _ (Left n) = Left n
   fmap f (Right r) = Right (f r)


