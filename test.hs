import System.IO

list' = []

inventoryLoadFile :: String -> IO()
inventoryLoadFile location = do
             inh <- openFile ("db/" ++ location) ReadMode
             loadFileLoop inh
             hClose inh

loadFileLoop :: Handle -> IO()
loadFileLoop inh = do
               ineof <- hIsEOF inh
               if ineof
                  then return()
                  else do inpStr <- hGetLine inh
                          putStrLn inpStr
                          loadFileLoop inh

s = [x | x <- [0..10]]
