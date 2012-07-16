module Customer where

-- Customer -- 
type CustomerId = Int
data Customer = Customer {
      customerId :: CustomerId,
      customerName :: String,
      customerAddress :: String
      } deriving (Show, Read)

