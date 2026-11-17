import Data.Maybe (fromJust)
import Data.List (nub)
import System.Process (CreateProcess(env))

type Nume = String
data Prop
    = Var Nume
    | F
    | T
    | Not Prop
    | Prop :|: Prop
    | Prop :&: Prop
    | Prop :->: Prop
    | Prop :<->: Prop
    deriving Eq
infixr 2 :|:
infixr 3 :&:
infixr 1 :->:
infixr 0 :<->:


-- v -> sau 
-- v in jos -> si

p1 :: Prop
p1 = (Var "P" :|: Var "Q") :&: (Var "P" :&: Var "Q")

p2 :: Prop
p2 = (Var "P" :|: Var "Q") :&: (Not (Var "P") :&: Not (Var "Q"))

p3 :: Prop
p3 = (Var "P" :&: (Var "Q" :|: Var "R")) :&: ((Var "P" :|: Not (Var "Q")) :&: (Not (Var "P") :|: Var "R"))



instance Show Prop where
    show (Var nume) = nume
    show (Not p) = "(~" ++ show p ++ ")"
    show (q :&: p) = "(" ++ show q ++ " & " ++ show p ++ ")" 
    show (q :|: p) = "(" ++ show q ++ " | " ++ show p ++ ")"    
    show (q :->: p) = "(" ++ show q ++ " -> " ++ show p ++ ")"
    show (q :<->: p) = "(" ++ show q ++ " <-> " ++ show p ++ ")"


test_ShowProp :: Bool
test_ShowProp = show (Not (Var "P") :&: Var "Q") == "((~P) & Q)"


type Env = [(Nume, Bool)]

impureLookup :: Eq a => a -> [(a,b)] -> b
impureLookup a = fromJust . lookup a


eval :: Prop -> Env -> Bool
eval (Var p) env = impureLookup p env
eval (Not p) env = not (eval p env)
eval (p :&: q) env = (eval p env) && (eval q env)
eval (p :|: q) env = (eval p env) || (eval q env)
eval (p :->: q) env = not (eval p env) || eval q env
eval (p :<->: q) env = (eval p env) == (eval q env)


test_eval = eval (Var "P" :|: Var "Q") [("P", True), ("Q", False)] == True

recurs :: Prop -> [Nume]
recurs (Var p) = [p]
recurs (Not p) = recurs p
recurs (p :&: q) = nub (recurs p ++ recurs q)
recurs (p :|: q) = nub (recurs p ++ recurs q)
recurs (p :->: q) = nub (recurs p ++ recurs q)
recurs (p :<->: q) = nub (recurs p ++ recurs q)


variabile :: Prop -> [Nume]
variabile prop = recurs prop


test_variabile = variabile (Not (Var "P") :&: Var "P") == ["P"]


envs :: [Nume] -> [Env]
envs [] = [[]]
envs (x : xs) = [ (x, val) : env | val <- [True, False], env <- envs xs]


test_envs = envs ["P", "Q"] == [ [ ("P",False), ("Q",False) ] , [ ("P",False) , ("Q",True) ], [ ("P",True), ("Q",False) ], [ ("P",True), ("Q",True) ]]   


helper :: Prop -> [Env] -> Bool
helper prop [] = False
helper prop (x : rest) = eval prop x || helper prop rest

satisfiabila :: Prop -> Bool
satisfiabila prop = helper prop (envs (variabile prop))

test_satisfiabila1 = satisfiabila (Not (Var "P") :&: Var "Q") == True
test_satisfiabila2 = satisfiabila (Not (Var "P") :&: Var "P") == False

helper_valida :: Prop -> [Env] -> Bool
helper_valida prop [] = True
helper_valida prop (x : rest) = eval prop x && helper_valida prop rest

valida :: Prop -> Bool
valida prop = helper_valida prop (envs (variabile prop))


test_valida1 = valida (Not (Var "P") :&: Var "Q") == False
test_valida2 = valida (Not (Var "P") :|: Var "P") == True




echivalenta :: Prop -> Prop -> Bool
echivalenta prop1 prop2 = valida (prop1 :<->: prop2)



test_echivalenta1 = True
    ==
        (Var "P" :&: Var "Q") `echivalenta` (Not (Not (Var "P") :|: Not (Var "Q")))
test_echivalenta2 = False
    ==
        (Var "P") `echivalenta` (Var "Q")