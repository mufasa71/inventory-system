module Inventory where
import System.IO

type StockCode = Int
type UnitPrice = Double
type DiscountPrice = Double
type Description = String


data Stock = Stock { stockCode :: StockCode,
                   unitPrice :: UnitPrice,
                   discountPrice :: DiscountPrice,
                   description :: Description 
                 } deriving (Show, Read)

list' = []

--stockList :: String -> [Stock]
--stockList stock = list':stock 

readStockFile :: FilePath -> IO()
readStockFile location = do
                           input <- openFile ("db/" ++ location) ReadMode -- monads
                           loadStockFile input
                           hClose input

loadStockFile :: Handle ->IO ()
loadStockFile input = do
                        inenof <- hIsEOF input
                        if inenof then
                           return ()
                           else do inpStr <- hGetLine input
                                   print inpStr
                                   loadStockFile input -- recursion

show' :: String -> IO ()
show' filepath = do
                  stock <- load filepath
                  let res = stock
                  print res
          
load :: FilePath -> IO Stock 
load f = do s <- readFile f
            return (read s :: Stock)
