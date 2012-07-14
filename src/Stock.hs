-- Stock representation
module Stock

-- Synonims
type StockCode = Int
type UnitPrice = Double
type DiscountPrice = Double
type Description = String

data Stock = Stock { stockCode :: StockCode,
                   unitPrice :: UnitPrice,
                   discountPrice :: DiscountPrice,
                   description :: Description 
                 } deriving (Show, Read)
