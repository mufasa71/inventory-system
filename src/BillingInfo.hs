-- General synonyms --
type Address = [String]

-- Billing Info --

type CardHolder = String
type CardNumber = String

data BillingInfo = CreditCard {
      cardNumber :: CardNumber,
      cardHolder :: CardHolder,
      address ::  Address } | CashOnDelivery
                            | Invoice CustomerId
      deriving (Show)
