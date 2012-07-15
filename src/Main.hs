module Main where
import System.IO
import Control.Monad
import Account
import Stock

main :: IO ()
main = do
  putStrLn "----------Welcome to Inventory System----------"
  credentials <- login
  accounts <- loadAccounts db_path
  if authenticate credentials accounts
    then do
      putStrLn "You was successfully logged in"
      processMenu
    else do putStrLn "Username or password does not match"
  putStrLn "Program terminated. Bye!"

login :: IO (UserName, Password)
login = do
  putStrLn "Please enter your username: "
  username <- getLine
  putStrLn "Password: "
  password <- getLine
  return (username, password)

menu = do
  putStrLn "Make your choise: "
  putStrLn "1. Read stock file"
  putStrLn "2. Add unit to stock"
  putStrLn "3. Remove unit from stock"
  putStrLn "4. Sort stock"
  putStrLn "4. Read orders file"
  putStrLn "5. Process orders"

processMenu = do
  menu
  line' <- getLine
  let choise = read line' :: Int
  case choise of 1 -> printStock $ loadStock stock_db 
                 2 -> addUnitAndSave
                 3 -> removeUnit
                 4 -> stockSorting
  processMenu
