module Category

-- Category --                      
type CategoryId = Int
data Category = Category { categoryId :: CategoryId
                         } deriving (Show, Read)
