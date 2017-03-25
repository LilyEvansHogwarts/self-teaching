import Supply
import System.Random hiding (next)
import Control.Arrow (first)
randomsIO :: Random a => IO [a]
randomsIO = getStdRandom $ \g -> let (a,b) = split g
                                 in (randoms a,b)

randomsIO_golf :: Random a => IO [a]
randomsIO_golf = getStdRandom (first randoms . split)


