-- Stock representation
module Stock where

import System.IO
import System.Directory
import Data.List
import Data.Maybe
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

discountPriceSort :: Stock -> Stock -> Ordering
discountPriceSort a b | discountPrice a >= discountPrice b = GT
                      | otherwise = LT

descriptionSort :: Stock -> Stock -> Ordering
descriptionSort a b | description a >= description b = GT
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

sortByUnitPrice :: IO([Stock]) -> IO([Stock])
sortByUnitPrice stockList = do
  oldStockList <- stockList
  let newStockList = sortBy unitPriceSort oldStockList
  return (newStockList)

sortByDiscountPrice :: IO([Stock]) -> IO([Stock])
sortByDiscountPrice stockList = do
  oldStockList <- stockList
  let newStockList = sortBy discountPriceSort oldStockList
  return (newStockList)

sortByDescription :: IO([Stock]) -> IO([Stock])
sortByDescription stockList = do
  oldStockList <- stockList
  let newStockList = sortBy descriptionSort oldStockList
  return (newStockList)

stockSorting = do
  putStrLn "Sort by?"
  putStrLn "  1. Price"
  putStrLn "  2. Discount price"
  putStrLn "  3. Description" 
  numberString <- getLine
  let choise = read numberString
  case choise of 1 -> printStock $ sortByUnitPrice $ loadStock stock_db
                 2 -> printStock $ sortByDiscountPrice $ loadStock stock_db
                 3 -> printStock $ sortByDescription $ loadStock stock_db
                 otherwise -> putStrLn "not exists"

addUnitAndSave= do
  stock <- addUnit
  _ <- saveStock stock
  putStrLn $ show stock

stockConcat :: [Stock] -> [Stock] -> [Stock]
stockConcat [] [] = []
stockConcat [] (y:ys) = y:(stockConcat [] ys)
stockConcat (x:xs) [] = x:(stockConcat xs [])
stockConcat xs ys = (stockConcat ys []) ++ (stockConcat [] xs)

stockReplicate :: Int -> Stock -> [Stock]
stockReplicate n x | n <= 0 = []
                   | otherwise = x:stockReplicate (n - 1) x

findByCode :: StockCode -> IO (Maybe Stock)
findByCode n = do
  stockList <- loadStock stock_db
  let stock = find (\x -> stockCode x == n) stockList
  return (stock)

findByDescription :: Description -> IO (Maybe Stock)
findByDescription d = do
  stockList <- loadStock stock_db
  let stock = find (\x -> description x == d) stockList
  return (stock)

doconcat :: IO ()
doconcat = do
  putStrLn "Specify file to append:"
  file <- getLine
  source <- loadStock file
  destination <- loadStock stock_db
  printStock $ return (stockConcat source destination)

doreplicate = do
  putStrLn "Enter stock code to replicate:"
  codeString <- getLine
  let code = read codeString
  putStrLn "How much to replicate?"
  numberString <- getLine
  let number = read numberString
  stock <- findByCode code
  let stockToReplicate = fromJust stock
  printStock $ return (stockReplicate number stockToReplicate)

findUnitBy = do
  putStrLn "Find unit by:"
  putStrLn "   1. Code"
  putStrLn "   2. Description"
  choiseString <- getLine
  let choise = read choiseString
  case choise of 1 -> promtFindByCode
                 2 -> promtFindBytDescription
                 otherwise -> putStrLn "not exists"

promtFindByCode = do
  putStrLn "Enter stock code"
  codeString <- getLine
  let code = read codeString
  stock <- findByCode code
  let stockFound = fromJust stock
  printStock $ return [stockFound]

promtFindBytDescription = do
  putStrLn "Enter description"
  description <- getLine
  stock <- findByDescription description
  let stockFound = fromJust stock
  printStock $ return [stockFound]
