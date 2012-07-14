-- Stock representation
module Stock where
import System.IO
import System.Directory
import Data.List
import Control.Monad
import Control.Exception

-- Synonyms
type StockCode = Int
type UnitPrice = Double
type DiscountPrice = Double
type Description = String

stock_db = "db/stock_db"

data Stock = Stock { stockCode :: StockCode,
                   unitPrice :: UnitPrice,
                   discountPrice :: DiscountPrice,
                   description :: Description } deriving (Show, Read, Ord, Eq)

unitPriceSort :: Stock -> Stock -> Ordering
unitPriceSort a b | unitPrice a >= unitPrice b = GT
                  | otherwise = LT

loadStock :: FilePath -> IO ([Stock])
loadStock path = do
  file <- readFile path
  let list' = [a | a <- map read (lines file) :: [Stock]]
  return (list')

printStock :: IO ([Stock]) -> IO ()
printStock input = do
  stockList <- input  
  putStrLn "Stock Code  |Price\t|Discount Price\t|Description"
  putStrLn "_____________________________________________________"
  prettyPrintedStock <- forM stockList (\unit -> do
      return $ show (stockCode unit) ++ "\t    |$ " ++ show (unitPrice unit) ++ "\t|$ " ++ show (discountPrice unit) ++ "\t|" ++ show (description unit))
  mapM_ putStrLn prettyPrintedStock

addUnit :: IO (Stock)
addUnit = do
  putStrLn "Enter description: "
  description <- getLine
  putStrLn "Enter price: "
  price <- getLine
  putStrLn "Enter discount price: "
  disPrice <- getLine
  stock <- loadStock stock_db
  let code = (+1) $ stockCode $ last stock
  return $ Stock{stockCode=code, unitPrice=read price::Double, discountPrice=read disPrice::Double, description=description}

saveStock :: Stock -> IO ()
saveStock stock = do
  contents <- readFile stock_db
  let oldStockList = lines contents
      newStockList = unlines $ oldStockList ++ [(show stock)]
  (tempName, tempHandle) <- openTempFile "db" "temp"
  hPutStr tempHandle newStockList
  hClose tempHandle
  removeFile "db/stock_db"
  renameFile tempName "db/stock_db"

removeUnit = do
  contents <- readFile stock_db
  let oldStockList = lines contents
      numberedStock = zipWith (\n line -> show n ++ " - " ++ line) [0..] oldStockList
  putStrLn "These are stock units: "
  mapM_ putStrLn numberedStock
  putStrLn "Which one you want to delete?"
  numberString <- getLine
  let number = read numberString
      newStockList = unlines $ delete (oldStockList !! number) oldStockList
  bracketOnError (openTempFile "db" "temp")
    (\(tempName, tempHandle) -> do
      hClose tempHandle
      removeFile tempName)
    (\(tempName, tempHandle) -> do
      hPutStr tempHandle newStockList
      hClose tempHandle
      removeFile "db/stock_db"
      renameFile tempName "db/stock_db")

sortByUnitPrice :: [Stock] -> [Stock]
sortByUnitPrice stockList = sortBy unitPriceSort stockList

test = printStock $ loadStock stock_db
test2 = do
  stock <- addUnit
  _ <- saveStock stock
  putStrLn $ show stock
