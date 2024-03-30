module Split where

split::[a]->Int->([a],[a])
split list v = (take v list, drop v list)
