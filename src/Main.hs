module Main where
import System.IO
import Inventory
import Account

main :: IO ()
main = do
       putStrLn "----------Welcome to Inventory System----------"
       credentials <- login
       accounts <- loadAccounts db_path
       if authenticate credentials accounts
       then do
          putStrLn "You was successfully logged in"
          menu
          processMenu
       else putStrLn "Username or password does not match"
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
  putStrLn "2. Read orders file"
  putStrLn "3. Process orders"

processMenu = do
  line' <- getLine
  let choise = read line' :: Int
  case choise of 1 -> putStrLn "One"
                 2 -> putStrLn "Two"
                 3 -> putStrLn "Process orders"
