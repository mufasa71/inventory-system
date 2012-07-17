module Customer where
import Data.List
-- Customer -- 
type CustomerId = Int
data Customer = Customer {
      customerId :: CustomerId,
      customerName :: String,
      customerAddress :: String
      } deriving (Show, Read)


customers_db = "db/customers_db"

loadCustomers :: FilePath -> IO ([Customer])
loadCustomers path = do
  file <- readFile path
  let list' = [a | a <- map read (lines file) :: [Customer]]
  return (list')

findCustomer :: Int -> IO (Maybe Customer)
findCustomer n = do
  customers <- loadCustomers customers_db
  let customer = find (\x -> customerId x == n) customers
  return (customer)
