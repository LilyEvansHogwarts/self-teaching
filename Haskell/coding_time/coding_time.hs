import System.Directory
import Data.List

data TAM = TAM{time :: Int, mode :: String} deriving (Show,Read)

--get [x,y], x denotes the time (string type), y denotes the mode, get time and mode from a string
time_and_mode x = [take 8 first_mode,takeWhile not_colon (drop 9 first_mode)]
   where not_backslash x = (x /= '/')
         not_colon x = (x /= ';')
         first_mode = takeWhile not_backslash (drop 11 x)

--x denotes hours, y denotes minutes, z denotes seconds (string type), get time from the time string
time_into_number (x:y:z:_) = (3600 * hours) + (60 * minutes) + seconds
   where hours = read x :: Int
         minutes = read y :: Int
         seconds = read z :: Int
time_into_number _ = 0


splitWith s [] = []
splitWith s xss@(x:xs) = if (x == s)
                            then splitWith s xs
                            else first:(splitWith s second)
   where not_s x = (x /= s)
         first = takeWhile not_s xss
         second = dropWhile not_s xss

--get the time (int type) and mode (string type) from a string
number_and_mode xs = TAM h y
   where [x,y] = time_and_mode xs
         z = splitWith ':' x
         h = time_into_number z

--delete the write mode TAM, if it is before another write mode
open_write_list pre x [] = case (mode x) of
                            "open " -> pre
                            "create " -> pre
                            "write" -> (pre ++ [x])
                            _-> pre 
open_write_list pre x (y:next) = if ((xm == "open ") || (xm == "create "))
                                    then open_write_list (pre ++ [x]) y next
                                    else if ((ym == "open ") || (ym == "create "))
                                            then open_write_list (pre ++ [x]) y next
                                            else open_write_list pre y next
   where xm = mode x
         ym = mode y

--use the neighboring open and write mode to get the total time
coding_time_iter [] result = result
coding_time_iter (x:y:xs) result = if (t > 100)
                                 then coding_time_iter xs (result + t)
                                 else coding_time_iter xs result
   where tx = time x
         ty = time y
         t = ty - tx
coding_time_iter _ result = result

--use the total time number to generate a standard clock time string
number_to_time x = nle hours ++ ":" ++ nle minutes ++ ":" ++ nle seconds
   where hours = show (x `div` 3600)
         hours_rem = x `mod` 3600
         minutes = show (hours_rem `div` 60)
         seconds = show (hours_rem `mod` 60)
         nle xs = if ((length xs) == 2)
                                 then xs
                                 else "0" ++ xs

--get the file extension
classify_ x = takeWhile not_semi_or_wh $ reverse (takeWhile not_dot (reverse x))
   where not_dot s = (s /= '.') 
         not_semi_or_wh s = ((s /= ';') && (s /= ' '))

--classify the file with its extension, and output a string
classify_list_iter scm hs cpp c md [] = sch ++ has ++ cpl ++ cl ++ mdd ++ total
   where scht = coding_time scm
         hast = coding_time hs
         cplt = coding_time cpp
         clt = coding_time c
         mddt = coding_time md
         sch = "\n******************************************\nScheme: " ++ (number_to_time scht) ++ "\n"
         has = "Haskell: " ++ (number_to_time hast) ++ "\n"
         cpl = "C++: " ++ (number_to_time cplt) ++ "\n"
         cl = "C: " ++ (number_to_time clt) ++ "\n"
         mdd = "Markdown: " ++ (number_to_time mddt) ++ "\n******************************************\n"
         total = "total coding time: " ++ (number_to_time (scht + hast + cplt + clt + mddt)) ++ "\n******************************************\n"
classify_list_iter scm hs cpp c md (x:xs) = 
   let cx = classify_ x
   in if (cx == "scm")
         then classify_list_iter (scm ++ [x]) hs cpp c md xs
         else if (cx == "hs")
                 then classify_list_iter scm (hs ++ [x]) cpp c md xs
                 else if (cx == "cpp") 
                         then classify_list_iter scm hs (cpp ++ [x]) c md xs
                         else if (cx == "c")
                                 then classify_list_iter scm hs cpp (c ++ [x]) md xs
                                 else if (cx == "md")
                                         then classify_list_iter scm hs cpp c (md ++ [x]) xs
                                         else classify_list_iter scm hs cpp c md xs
{-   case (classify x) of
      "scm" -> classify_list_iter (scm ++ [x]) hs cpp c md xs
      "hs" -> classify_list_iter scm (hs ++ [x]) cpp c md xs
      "cpp" -> classify_list_iter scm hs (cpp ++ [x]) c md xs
      "c" -> classify_list_iter scm hs cpp (c ++ [x]) md xs
      "md" -> classify_list_iter scm hs cpp c (md ++ [x]) xs
      _ -> classify scm hs cpp c md xs
-}

--use the contents_list to generate coding time (int type)
coding_time [] = 0
coding_time xs = coding_time_iter (open_write_list [] (head time_list) (tail time_list)) 0
   where time_list = map number_and_mode xs

main = do
   dirName <- getCurrentDirectory
   putStrLn "enter the date you want to search (for example. 2017.01.09):"
   ti <- getLine 
   let [year,month,day] = splitWith '.' ti
   let path = "/home/lilyevans/activity/" ++ year ++ "/" ++ month ++ "/" ++ day ++ ".log"
   contents <- readFile path
   let contents_list = lines contents
   let ld = classify_list_iter [] [] [] [] [] contents_list
   putStrLn ld
