import System.IO
    start :: IO ()
    start = do
    putStrLn "------------------"
    putStrLn "---- ATM Bank ----"
    putStrLn "------------------"
    putStrLn ""
    putStrLn "1- Login"
    putStrLn ""
    putStrLn "2- Exit"
    putStrLn ""
    putStrLn "Enter your choice: "
    opt <- getLine
    if (opt == "1")
    then do
    validation
    else
    do
    putStrLn "Thank you for using Bank ATM"	
    mainMenu :: IO ()
    mainMenu =
    do
    putStrLn "------------------"
    putStrLn "---- ATM Bank ----"
    putStrLn "------------------"
    putStrLn ""
    putStrLn "1- Check Balance"
    putStrLn ""
    putStrLn "2- Withdraw"
    putStrLn ""
    putStrLn "3- Deposit"
    putStrLn ""
    putStrLn "4- Change Password"
    putStrLn ""
    putStrLn "5- Back"
    putStrLn ""
    putStrLn "Enter your choice: "	
    opt <- getLine
    if(opt == "1") then do balance
    else do
    if(opt == "2") then do withdraw
    else do
    if(opt == "3") then do deposit
    else do
    if(opt == "4") then do changePW
    else
    do
    start
    balance :: IO ()
    balance =
    do
    putStrLn "Your balance is: "
    bal <- readFile "Balance.txt"
    putStrLn bal
    mainMenu
    withdraw :: IO ()
    withdraw =
    do
    putStrLn "Enter the amount: "
    b <- getLine
    bal <- readFile "Balance.txt"
    let wb = read b :: Int
    let obal = read bal :: Int
    if (wb < obal) then
    do
    let total = obal - wb
    let t = show total
    writeFile "Balance.txt" t
    mainMenu
    else
    do
    putStrLn "Amount is not valid"
    mainMenu
    deposit :: IO()	
    deposit =
    do
    putStrLn "Enter the amount: "
    a <- getLine
    bal <- readFile "Balance.txt"
    let amt = read a :: Int
    let obal = read bal :: Int
    let total = amt + obal
    let t = show total
    writeFile "Balance.txt" t
    mainMenu
    changePW :: IO ()
    changePW =
    do
    putStrLn "Enter new PIN number: "
    nPIN <- getLine
    writeFile "Password.txt" nPIN
    mainMenu
    validation :: IO ()
    validation =
    do
    putStrLn ""
    putStrLn "Enter your PIN Number: "
    kPIN <- getLine
    inPIN <- readFile "Password.txt"
    if (kPIN == inPIN)
    then
    do	
    mainMenu
    else
    do	
    putStrLn "Wrong PIN number"
    putStrLn ""
    start
