-- Stock representation
module Stock where
import System.IO
import Control.Monad

-- Synonyms
type StockCode = Int
type UnitPrice = Double
type DiscountPrice = Double
type Description = String

stock_db = "db/stock_db"

data Stock = Stock { stockCode :: StockCode,
                   unitPrice :: UnitPrice,
                   discountPrice :: DiscountPrice,
                   description :: Description } deriving (Show, Read)

loadStock :: FilePath -> IO ([Stock])
loadStock path = do
  file <- readFile path
  let list' = [a | a <- map read (lines file) :: [Stock]]
  return (list')

printStock :: IO ([Stock]) -> IO [()]
printStock input = do
  stockList <- input  
  putStrLn "Stock Code  |Price\t|Discount Price\t|Description"
  putStrLn "_____________________________________________________"
  prettyPrintedStock <- forM stockList (\item -> do
      return $ show (stockCode item) ++ "\t    |$ " ++ show (unitPrice item) ++ "\t|$ " ++ show (discountPrice item) ++ "\t\t|" ++ show (description item))
  mapM putStrLn prettyPrintedStock

test = printStock $ loadStock stock_db
