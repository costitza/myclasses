{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use even" #-}

verifL :: [Int] -> Bool
verifL xs = length xs `mod` 2 == 0
 
 
takefinal :: [a] -> Int -> [a]
takefinal xs n = drop (length xs - n) xs
 
 
remove :: [a] -> Int -> [a]
remove xs n = (take (n - 1) xs) ++ (drop (length xs - n) xs)
 
myreplicate :: Int -> Int -> [Int]
myreplicate 1 v = [v]
myreplicate n v = [v] ++ (myreplicate (n - 1) v)
 
 
sumImp :: [Int] -> Int
sumImp [] = 0
sumImp (x : xs) = 
    if x `mod` 2 == 1 then x + sumImp xs
    else sumImp xs
 
 
totalLen :: [String] -> Int
totalLen [] = 0
totalLen (x : xs) = 
    if (head x) == 'A' then (length x) + totalLen xs
    else totalLen xs
 
esteVoc x 
    | x == 'a' = True
    | x == 'e' = True
    | x == 'i' = True
    | x == 'o' = True
    | x == 'u' = True
    | otherwise = False
 
adun :: [Char] -> Int
adun "" = 0
adun (x : xs) = 
    if (esteVoc x) == True then 1 + adun xs
    else adun xs 
 
 
nrVocale :: [String] -> Int
nrVocale [] = 0
nrVocale (x : xs) = 
    if (reverse x) == x then adun x + nrVocale xs
    else nrVocale xs
 
 
adaugelem :: [Int] -> Int -> [Int]
adaugelem [] v = []
adaugelem (x : xs) v = 
    if x `mod` 2 == 0 then [x, v] ++ adaugelem xs v
    else x : adaugelem xs v
 
 
semiPareComp :: [Int] -> [Int]
semiPareComp l = [ x `div` 2 | x <- l, even x ]
 
 
divizori :: Int -> [Int]
divizori n = [x | x <- [1..n], n `mod` x == 0]
 
 
listadiv :: [Int] -> [[Int]]
listadiv l = [divizori x | x <- l]
 
-- interval in 2 indexuri date
inInterval min max l = drop (min - 1) . take max $ l
 
 
helper min max [] val = []
helper min max (x : xs) val
    | min - 1 <= val && val < max = x : helper min max xs (val + 1)
    | otherwise = helper min max xs (val + 1)
 
inIntervalRec min max l = helper min max l 0
 
pozitive l = sum [1 | x <- l, x > 0]
 
pozitiveRec [] = 0
pozitiveRec (x : xs)
    | x > 0 = 1 + pozitiveRec xs
    | otherwise = pozitiveRec xs
 
 
pozitiiImpComp l = [index | (x, index) <- zip l [0,1..], x `mod` 2 /= 0]
 
helper1 [] val = []
helper1 (x : xs) val
    | x `mod` 2 /= 0 = [val] ++ helper1 xs (val + 1)
    | otherwise = helper1 xs (val + 1)
 
pozitiiImpRec l = helper1 l 0