module NaturalNumbers where

data N = Zero | Succ N deriving (Eq, Show)

zero  = Zero
one   = Succ Zero
two   = Succ (Succ Zero)
three = Succ (Succ (Succ Zero)
four  = Succ (Succ (Succ (Succ Zero)
five  = Succ (Succ (Succ (Succ (Succ Zero)
six   = Succ (Succ (Succ (Succ (Succ (Succ Zero)
seven = Succ (Succ (Succ (Succ (Succ (Succ (Succ Zero)
eight = Succ (Succ (Succ (Succ (Succ (Succ (Succ (Succ Zero)
nine  = Succ (Succ (Succ (Succ (Succ (Succ (Succ (Succ (Succ Zero)