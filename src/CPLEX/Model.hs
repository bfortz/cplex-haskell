module CPLEX.Model
where

data LinExpr v = LinExpr [(Double, v)] 

instance Show v => Show (LinExpr v) where
  show (LinExpr [(c,var)]) = show c ++ " * " ++ show var
  show (LinExpr ((c,var):xs)) = show (LinExpr [(c,var)]) ++ " + " ++ show (LinExpr xs)

-- For testing purposes
--

data MyVar = X Int | Y Int deriving Show

linexpr1 = LinExpr [(1.0,Y 3),(3.0,X 2)]
