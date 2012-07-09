tidySecond :: [a] -> Maybe a

tidySecond (_:x:_) = Just x
tidySecond _ = Nothing
