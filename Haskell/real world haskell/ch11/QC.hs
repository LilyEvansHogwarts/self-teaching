module QC 
(
   prop_empty_id,
   prop_char,
   prop_text,
   prop_line,
   prop_double,
   prop_hcat,
   prop_punctuate'
) where

import Test.QuickCheck.Arbitrary
import Test.QuickCheck.Gen
import Control.Monad
import Data.List

data Doc = Empty 
         | Char Char
         | Text String
         | Line
         | Concat Doc Doc
         | Union Doc Doc
         deriving (Show,Eq)

instance Arbitrary Doc where
   arbitrary = oneof [return Empty,liftM Char arbitrary,liftM Text arbitrary,return Line,liftM2 Concat arbitrary arbitrary,liftM2 Union arbitrary arbitrary]

--instance Arbitrary Char where
--   arbitrary = elements (['A'..'Z'] ++ ['a'..'z'] ++ "~!@#$%^&*()")

empty :: Doc
empty = Empty

(<>) :: Doc -> Doc -> Doc
x <> Empty = x
Empty <> x = x
x <> y = Concat x y

prop_empty_id x = empty <> x == x && x <> empty == x

char :: Char -> Doc
char c = Char c

text :: String -> Doc
text s = Text s

line :: Doc
line = Line

double :: Double -> Doc
double d = text (show d)

hcat :: [Doc] -> Doc
hcat = fold (<>)

fold :: (Doc -> Doc -> Doc) -> [Doc] -> Doc
fold f = foldr f empty

punctuate :: Doc -> [Doc] -> [Doc]
punctuate p [] = []
punctuate p [d] = [d]
punctuate p (d:ds) = (d <> p) : punctuate p ds

prop_char c = char c == Char c

prop_text s = text s == Text s

prop_line = line == Line

prop_double d = double d == text (show d)

prop_hcat xs = hcat xs == glue xs
   where glue [] = empty
         glue (d:ds) = d <> glue ds

prop_punctuate s xs = punctuate s xs == intersperse s xs

prop_punctuate' s xs = punctuate s xs == combine (intersperse s xs)
   where combine [] = []
         combine [x] = [x]
         combine (x:Empty:ys) = x : combine ys
         combine (Empty:x:ys) = x : combine ys
         combine (x:y:ys) = (Concat x y) : combine ys

prop_mempty_id x = mempty `mappend` x == x && x `mappend` mempty == (x::Doc)


