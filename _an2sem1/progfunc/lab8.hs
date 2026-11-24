data Expr = Const Int -- integer constant
    | Expr :+: Expr -- addition
    | Expr :*: Expr -- multiplication
    deriving Eq

data Operation = Add | Mult 
    deriving (Eq, Show)

data Tree = Lf Int -- leaf
    | Node Operation Tree Tree -- branch
    deriving (Eq, Show)




instance Show Expr where
  show (Const n) = show n
  show (e1 :+: e2) = "(" ++ show e1 ++ " + " ++ show e2 ++ ")"
  show (e1 :*: e2) = "(" ++ show e1 ++ " * " ++ show e2 ++ ")"


evalExp :: Expr -> Int
evalExp (Const n) = n
evalExp (e1 :+: e2) = evalExp e1 + evalExp e2
evalExp (e1 :*: e2) = evalExp e1 * evalExp e2


evalArb :: Tree -> Int
evalArb (Lf n) = n
evalArb (Node Add t1 t2) = evalArb t1 + evalArb t2
evalArb (Node Mult t1 t2) = evalArb t1 * evalArb t2


expToArb :: Expr -> Tree
expToArb (Const n) = Lf n
expToArb (e1 :+: e2) = Node Add (expToArb e1) (expToArb e2)
expToArb (e1 :*: e2) = Node Mult (expToArb e1) (expToArb e2)



data Punct = Pt [Int]
data Arb = Vid | F Int | N Arb Arb
    deriving Show

class ToFromArb a where
    toArb :: a -> Arb
    fromArb :: Arb -> a


instance Show Punct where
  show (Pt xs) = "(" ++ foldr (\x acc -> if acc == "" then show x else show x ++ ", " ++ acc) "" xs ++ ")"


instance ToFromArb Punct where
  toArb (Pt [])     = Vid
  toArb (Pt (x:xs)) = N (F x) (toArb (Pt xs))

  fromArb Vid = Pt []
  fromArb (F x) = Pt [x]
  fromArb (N st dr) = let Pt xs = fromArb st
                          Pt ys = fromArb dr
                      in Pt (xs ++ ys)




data Geo a = Square a | Rectangle a a | Circle a
    deriving Show

class GeoOps g where
    perimeter :: (Floating a) => g a -> a
    area :: (Floating a) => g a -> a



instance GeoOps Geo where
  perimeter (Square l) = 4 * l
  perimeter (Rectangle l w) = 2 * (l + w)
  perimeter (Circle r) = 2 * pi * r

  area (Square l) = l * l
  area (Rectangle l w) = l * w
  area (Circle r) = pi * r * r


instance (Floating a, Eq a) => Eq (Geo a) where
    g1 == g2 = perimeter g1 == perimeter g2

