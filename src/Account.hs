module Account where
import System.IO
import Control.Monad(liftM)
-- Account --
type Password = String
type UserName = String

db_path = "db/accounts_db"

data Account = Account {
      username :: UserName,
      password :: Password
      } deriving (Show, Read)

-- instance of class Eq
instance Eq Account where
  Account username1 password1 == Account username2 password2 = and [(username1 == username2),(password1 == password2)]

-- guard actions
authenticate :: (UserName, Password) -> [Account] -> Bool
authenticate (_username, _password) accounts
  | account `elem` accounts = True
  | otherwise = False
  where account = Account{username=_username, password=_password}

loadAccounts :: FilePath -> IO([Account])
loadAccounts path = do
  file <- readFile path
  let list' = [a | a <- map read (lines file) :: [Account]]
  return (list')
