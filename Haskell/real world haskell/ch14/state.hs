module State where

import System.Random
import Control.Monad

newtype State s a = State {
   runState :: s -> (a,s)
   }

type RandomState a = State StdGen a

returnState :: a -> State s a
returnState a = State $ \s -> (a,s)

bindState :: (State s a) -> (a -> State s b) -> (State s b)
bindState m k = State $ \s -> let (a,s') = runState m s
                                in runState (k a) s'

get :: State s s
get = State $ \s -> (s,s)

put :: s -> State s ()
put s = State $ \_ -> ((),s)

getRandom :: Random a => RandomState a
getRandom = get >>= \gen -> let (val,gen') = random gen 
                            in put gen' >> return val

getTwoRandoms :: Random a => RandomState (a,a)
getTwoRandoms = liftM2 (,) getRandom getRandom

runTwoRandoms :: IO (Int,Int)
runTwoRandoms = do
   oldState <- getStdGen
   let (result,newState) = runState getTwoRandoms oldState
   setStdGen newState
   return result

data CountedRandom = CountedRandom {
   crGen :: StdGen,
   crCount :: Int
   }

type CRState = State CountedRandom

getCountedRandom :: Random a => CRState a
getCountedRandom = do
   st <- get
   let (val,gen') = random (crGen st)
   put CountedRandom { crGen = gen', crCount = crCount st + 1}
   return val

getCount :: CRState Int
getCount = crCount `liftM` get

 
