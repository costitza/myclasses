import GHC.Base (TrName(TrNameD))
import Control.Concurrent (Chan)

factori :: Int -> [Int]
factori x = [d | d <- [1..x], x `mod` d == 0]

prim :: Int -> Bool
prim x = if length (factori x) == 2 then True
    else False


numerePrime :: Int -> [Int]
numerePrime n = [x | x <- [2..n], prim x == True]


myzip3 (x : xs) (y : ys) (z : zs) = (x, y, z) : myzip3 xs ys zs
myzip3 _ _ _ = []


firstEl :: [(a, b)] -> [a]
firstEl xs = map fst xs


sumList :: [[Int]] -> [Int]
sumList xs = map sum xs


prel2 :: [Int] -> [Int]
prel2 xs = map (\x -> if even x then x `div` 2 else x * 2) xs


selectCaract x xs = filter (elem x) xs

patratImpar xs = (map (^ 2)  . filter odd) xs

patratpozImpar :: [Int] -> [Int]
patratpozImpar xs = (map ((^ 2) . fst) . filter (odd . snd)) (zip xs [0..])


isVowel c = c `elem` "aeiouAEIOU"

numaiVocale :: [[Char]] -> [[Char]]
numaiVocale xs = map (filter (isVowel)) xs


mymap :: (a -> b) -> [a] -> [b]
mymap _ [] = []
mymap f (x : xs) = f x : mymap f xs 


myfilter :: (a -> Bool) -> [a] -> [a]
myfilter _ [] = []
myfilter f (x : xs)
    | f x = x : myfilter f xs
    | otherwise = myfilter f xs