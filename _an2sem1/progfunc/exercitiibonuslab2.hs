{-# OPTIONS_GHC -Wno-tabs #-}
import Data.Time.Format.ISO8601 (yearFormat)



numarcifre :: Integer -> Integer
numarcifre x 
	| x < 10 = 1
	| otherwise = 1 + numarcifre (x `div` 10)



prodcifpar :: Integer -> Integer
prodcifpar x
    | x == 0 = 1
    | x `mod` 2 == 0 = x `mod` 10 * prodcifpar (x `div` 10)
    | otherwise = prodcifpar (x `div` 10)


helper 0 y = y
helper x y = helper (x `div` 10) (y * 10 + x `mod` 10)

oglindit :: Integer -> Integer
oglindit x = helper x 0



forprim x d 
    | d * d > x = True
    | x `mod` d /= 0 = forprim x (d + 2)
    | otherwise = False

prim :: Integer -> Bool
prim x
    | x < 2 || x > 2 && x `mod` 2 == 0 = False
    | otherwise = forprim x 3
