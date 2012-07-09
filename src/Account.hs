module Account where
import System.IO
-- Account --
type AccountId = Int
type Password = String
type UserName = String

data Account = Account {
      accountId :: AccountId,
      username :: UserName,
      password :: Password
      } deriving (Show, Read)

-- instance of class Eq
instance Eq Account where
  Account x username1 password1 == Account y username2 password2 = and [(username1 == username2),(password1 == password2)]

-- read accounts from file db/accounts_db
fetchAccounts :: String -> String
fetchAccounts fileName = do
                          readFile("db/" ++ fileName)
                         --let accountList = lines db
                         --putStrLn accountList
                         --putStrLn (show db)
