module Inventory where
-- pattern matching
-- parametrized types
-- record syntax



inventoryLoadFile :: String -> IO ()
inventoryLoadFile location = do
                              input <- readFile location
                              let allLines = lines input
                              print allLines
