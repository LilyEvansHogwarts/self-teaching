import Test.QuickCheck.Arbitrary
import Test.QuickCheck.Gen

data Doc = Empty 
         | Char Char
         | Text String
         | Line
         | Concat Doc Doc
         | Union Doc Doc
         deriving (Show,Eq)

class Arbitrary a where
   arbitrary :: Gen a

data Ternary = Yes | No | Unknown deriving (Eq,Show)

instance Arbitrary Ternary where
   arbitrary = elements [Yes,No,Unknown]

instance (Arbitrary a,Arbitrary b) => Arbitrary (a,b) where
   arbitrary = do
      x <- arbitrary
      y <- arbitrary
      return (x,y)

instance Arbitrary Doc where
   arbitrary = do
      n <- choose (1,6) :: Gen Int
      case n of 
         1 -> return Empty
         2 -> do x <- arbitrary
                 return (Char x)
         3 -> do x <- arbitrary
                 return (Text x)
         4 -> return Line
         5 -> do x <- arbitrary
                 y <- arbitrary
                 return (Concat x y)
         6 -> do x <- arbitrary
                 y <- arbitrary
                 return (Union x y)

instance Arbitrary Char where
   arbitrary = elements (['A'..'Z'] ++ ['a'..'z'] ++ "~!@#$%^&*()")

empty :: Doc
empty = Empty

(<>) :: Doc -> Doc -> Doc
Empty <> y = y
x <> Empty = x
x <> y = Concat x y

char :: Char -> Doc
char c = Char c

line :: Doc
line = Line

text :: String -> Doc
text "" = Empty
text s = Text s

