module Item

-- Item --
type ItemId = Int
data Item = Item { itemId :: ItemId,
                         category :: Category,
                         qty_in_stock :: Int
                       } deriving (Show, Read)
