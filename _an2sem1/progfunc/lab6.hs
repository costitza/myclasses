import Text.Printf (FormatAdjustment)
import Distribution.Simple.Utils (listUnion)

data Fruct 
    = Mar String Bool
    | Portocala String Int


listaFructe = [Mar "Ionatan" False,
        Portocala "Sanguinello" 10,
        Portocala "Valencia" 22,
        Mar "Golden Delicious" True,
        Portocala "Sanguinello" 15,
        Portocala "Moro" 12,
        Portocala "Tarocco" 3,
        Portocala "Moro" 12,
        Portocala "Valencia" 2,
        Mar "Golden Delicious" False,
        Mar "Golden" False,
        Mar "Golden" True]


ePortocalaDeSicilia :: Fruct -> Bool
ePortocalaDeSicilia (Portocala soi _) = soi `elem` ["Tarocco", "Moro", "Sanguinello"]
ePortocalaDeSicilia (Mar _ _) = False


nrFeliiSicilia ::[Fruct] -> Int
nrFeliiSicilia [] = 0
nrFeliiSicilia (Portocala soi felii : xs)
    | ePortocalaDeSicilia (Portocala soi felii) = felii + nrFeliiSicilia xs 
    | otherwise = nrFeliiSicilia xs 
nrFeliiSicilia (Mar _ _ : xs) = nrFeliiSicilia xs


nrMereViermi :: [Fruct] -> Int
nrMereViermi lst = sum [1 | Mar _ True <- lst]


-- 2
type NumeA = String
type Rasa = String
data Animal = Pisica NumeA | Caine NumeA Rasa
    deriving Show



-- teste 
-- Animale de test
tom :: Animal
tom = Pisica "Tom"

rex :: Animal
rex = Caine "Rex" "Ciobanesc German"

lessie :: Animal
lessie = Caine "Lessie" "Collie"

garfield :: Animal
garfield = Pisica "Garfield"

-- Teste automate
test_vorbeste1 :: Bool
test_vorbeste1 = vorbeste tom == "Meow"

test_vorbeste2 :: Bool
test_vorbeste2 = vorbeste rex == "Woof"

test_rasa1 :: Bool
test_rasa1 = rasa rex == Just "Ciobanesc German"

test_rasa2 :: Bool
test_rasa2 = rasa lessie == Just "Collie"

test_rasa3 :: Bool
test_rasa3 = rasa tom == Nothing

test_rasa4 :: Bool
test_rasa4 = rasa garfield == Nothing



vorbeste :: Animal -> String
vorbeste (Pisica _) = "Meow"
vorbeste (Caine _ _) = "Woof"


rasa :: Animal -> Maybe String
rasa (Pisica _) = Nothing
rasa (Caine _ r) = Just r


-- 3
data Linie = L [Int]
    deriving Show
data Matrice = M [Linie]
    deriving Show

sumaLinie :: Linie -> Int
sumaLinie (L x) = sum x

verifica :: Matrice -> Int -> Bool
verifica (M linii) n = foldr (\(L line) acc -> (sum line == n) && acc) True linii

strictPoz :: [Int] -> Bool
strictPoz lst = foldr (\x acc -> (x > 0) && acc) True lst

doarPozN :: Matrice -> Int -> Bool
doarPozN (M lines) n = foldr (\(L line) acc -> if (length line) == n then (strictPoz line) && acc else acc) True lines  


corect :: Matrice -> Bool
corect (M []) = True
corect (M (L x : rest)) = all (\(L line) -> length line == length x) rest

test_veri1 = verifica (M[L[1,2,3], L[4,5], L[2,3,6,8], L[8,5,3]]) 10 == False
testPoz1 = doarPozN (M [L[1,2,3], L[4,5], L[2,3,6,8], L[8,5,3]]) 3 == True
testPoz2 = doarPozN (M [L[1,2,-3], L[4,5], L[2,3,6,8], L[8,5,3]]) 3 == False