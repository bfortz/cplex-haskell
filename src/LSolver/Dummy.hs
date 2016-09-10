module LSolver.Dummy(sol',  standardBounds) where

import Data.Ix as I
import qualified Data.Vector as V
import qualified Data.Sequence as S
import Data.Foldable as F
import LSolver.Bindings


data Equality = L Double | E Double | G Double
data Mat = Row Int | Col Int

data Var = X | Y | Z

objF :: Optimization Int
objF = Maximize [1 :# 0 , 2 :# 1, 3 :# 2]

st :: Constraints Int
st = Constraints [
                [(-1):#1, 1:#2, 1:#3] :< 20,
                [1:#1, (-3):#2, 1:#3] :< 30
            ]

bnds = [       (1, Just 0, Just 40),
            (2,Just 0,Nothing),
            (3, Just 0, Nothing)]

standardBounds (i,j) = map (\i' -> (i', Just 0, Nothing)) [i..j]

toBounds bounds varRange = F.toList $ aux bounds def
    where
        def = S.fromList [k | i <- I.range varRange, let k = (Just 0, Nothing)]
        aux [] s = s
        aux ((b,lb,ub):bs) s = aux bs (S.update (I.index varRange b) (lb,ub) s)

toConstraints constraints varRange = let (st, rhs) = toStandard constraints 0 [] [] varRange
    in (st, V.fromList rhs)
toStandard (Constraints []) _ accSt accRhs varRange = (reverse $ accSt, reverse $ accRhs)
toStandard (Constraints (b:bs)) rowI accSt accRhs varRange = case b of
        vars :< boundVal -> addRow vars L boundVal
        vars := boundVal -> addRow vars E boundVal
        vars :> boundVal -> addRow vars G boundVal
    where   addRow vars s boundVal = toStandard (Constraints bs) (rowI+1) (generateRow vars ++ accSt)
                                                ((s boundVal) : accRhs) varRange
            generateRow [] = []
            generateRow ((v :# i):vs) = (Row rowI, Col $ I.index varRange i, v):generateRow vs

sol' = do
    putStrLn "Test"
