module Order where
import Control.Monad
import Stock
import Customer

-- Synonyms
type OrderNumber = Int
type QuantityOrdered = Int

orders_db = "db/orders_db"

data Order = Order { ordStockCode :: StockCode,
                     customer :: CustomerId,
                     qtyOrdered :: QuantityOrdered,
                     price :: UnitPrice,
                     ordDescription :: Description } deriving (Show, Read, Ord, Eq)

printOrders :: IO ([Order]) -> IO ()
printOrders input = do
  orderList <- input  
  putStrLn "Stock code  |Quantity\t|Price\t|Description"
  putStrLn "_____________________________________________________"
  prettyPrintedOrder <- forM orderList (\order -> do
      return $ show (ordStockCode order) ++ "\t    |$ " ++ show (qtyOrdered order) ++ "\t|$ " ++ show (price order) ++ "\t|" ++ show (ordDescription order))
  mapM_ putStrLn prettyPrintedOrder
  
  
loadOrders :: FilePath -> IO ([Order])
loadOrders path = do
  file <- readFile path
  let list' = [a | a <- map read (lines file) :: [Order]]
  return (list')
