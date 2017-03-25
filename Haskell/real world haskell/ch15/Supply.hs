{-#LANGUAGE GeneralizedNewtypeDeriving #-}
{-#LANGUAGE FlexibleContexts #-}

module Supply 
(
   Supply,
   next,
   runSupply,
) where

import Control.Monad.State

newtype Supply s a = S (State [s] a) 

runSupply :: Supply s a -> [s] -> (a,[s])
runSupply (S m) xs = runState m xs

next :: Supply s (Maybe s)
next = S $ do st <- get
              case st of
                 [] -> return Nothing
                 (x:xs) -> do put xs
                              return (Just x)

unwraps :: Supply s a -> State [s] a
unwraps (S s) = s

