{-# LANGUAGE GeneralizedNewtypeDeriving #-}

unwraps :: Supply s a -> State [s] a
unwraps (S s) = s

instance Monad (Supply s) where
   s >>= m = S (unwraps s >>= unwraps . m)
   return = S . return
