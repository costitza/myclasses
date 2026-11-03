import Distribution.Simple.Program.HcPkg (list)


sumpatrimpare xs = foldr (+) 0 (map (** 2) (filter (odd) xs))


toateTrue xs = foldr (&&) True xs


allVerifies func xs = toateTrue . map (func) $ xs


mapFoldr f xs = foldr (\x next -> f x : next) [] xs


filterFoldr f xs = foldr (\x next -> if f x == True then x : next else next) [] xs



listToInt :: [Integer] -> Integer
listToInt xs = foldl (\res x -> res * 10 + x) 0 xs


rmChar :: Char -> String -> String
rmChar ch xs = foldr (\x res -> if x /= ch then x : res else res) [] xs


rmCharsRec :: String -> String -> String
rmCharsRec [] rest = rest
rmCharsRec (x : rest) beRemoved = let
        removed = rmChar x beRemoved
    in 
        rmCharsRec rest removed


rmCharsFold :: String -> String -> String
rmCharsFold xs beRemoved = foldr (\x next -> rmChar x next) beRemoved xs


myReverse xs = foldl (\x acc -> acc : x) [] xs


myElem x xs = foldr (\elem next -> elem == x || next) False xs


myUnzip :: [(a, b)] -> ([a], [b])
myUnzip xs = foldr (\x acc -> (fst x : fst acc, snd x : snd acc)) ([], []) xs


union lst1 lst2 = foldr (\x acc -> if x `notElem` acc then x : acc else acc) lst1 lst2

intersect lst1 lst2 = foldr (\x acc -> if x `elem` lst1 then x : acc else acc) [] lst2



insertTot x [] = [[x]]
insertTot x (y : ys) = (x : y : ys) : map (y :) (insertTot x ys)

helper :: Int -> [[Int]] -> [[Int]]
helper x [] = []
helper x (lst : rest) = (insertTot x lst) ++ (helper x rest)

permutations :: [Int] -> [[Int]]
permutations xs = foldr helper [[]] xs
