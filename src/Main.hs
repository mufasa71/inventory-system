module Main where
import System.IO
import Inventory
import Account

main :: IO ()
main = do
       putStrLn "Welcome to Inventory System"
       putStrLn "Please enter your username: "
       username <- getLine
       putStrLn "Password:"
       password <- getLine
       let account1 = Account{accountId = 999, username = username, password = password}
       let account2 = Account{accountId = 999, username = "shukhrat", password = "password"}
       let result = account1 == account2
       putStrLn (show result)
       putStrLn "You was successfully logged in"

