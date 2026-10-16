{-# OPTIONS_GHC -Wno-tabs #-}
import Data.List
 
myInt = 31415926535897932384626433832795028841971693993751058209749445923
 
double :: Integer -> Integer
double x = x+x
 
--maxim :: Integer -> Integer -> Integer
maxim x y = if (x > y)
               then x
          else y
 
max3 x y z = let
             u = maxim x y
             in (maxim  u z)
 
maxim3 :: Integer -> Integer -> Integer -> Integer
maxim3 x y z = 
	if (x > y)
		then if (x > z)
			then x
		else z
	else if (y > z)
		then y
	else z
 
maxim4 :: Integer -> Integer -> Integer -> Integer -> Integer
maxim4 x y z w = 
	let u = maxim3 x y z
	in if u > w
		then u
	else w
 
test4 :: Integer -> Integer -> Integer -> Integer -> Bool
test4 a b c d = let m = maxim4 a b c d
	in (m >= a) && (m >= b) && (m >= c) && (m >= d)
 

sumpatrat :: Integer -> Integer -> Integer
sumpatrat a b = a * a + b * b
 
 
paritate :: Integer -> String
paritate a = if a `mod` 2 == 0
	then "par"
	else "impar"


factorial :: Integer -> Integer
factorial 0 = 1
factorial a = a * factorial (a - 1)

functiad :: Integer -> Integer -> Bool
functiad x y = if (x > y * 2)
	then True
	else False


maximlista :: [Integer] -> Integer
maximlista [x] = x
maximlista (x : xs) =
	if (maximlista xs > x) then maximlista xs
	else x


poly :: Double -> Double -> Double -> Double -> Double
poly a b c x = a * x ^ 2 + b * x + c




eeny :: Integer -> String
eeny = undefined
 
fizzbuzz :: Integer -> String
fizzbuzz a 
	| a `mod` 15 == 0 = "fizzbuzz"
	| a `mod` 3 == 0 = "fizz"
	| a `mod` 5 == 0 = "buzz"
	| otherwise = ""

fizzbuzzif :: Integer -> String
fizzbuzzif a = 
	if (a `mod` 15 == 0) 
		then "fizzbuzz"
	else if (a `mod` 3 == 0) 
		then "fizz"
	else if (a `mod` 5 == 0) 
		then "buzz"
	else ""


fibonacciCazuri :: Integer -> Integer
fibonacciCazuri n
    | n < 2     = n
    | otherwise = fibonacciCazuri (n - 1) + fibonacciCazuri (n - 2)
 
fibonacciEcuational :: Integer -> Integer
fibonacciEcuational 0 = 0
fibonacciEcuational 1 = 1
fibonacciEcuational n =
    fibonacciEcuational (n - 1) + fibonacciEcuational (n - 2)
 
tribonacci :: Integer -> Integer
tribonacci 1 = 1
tribonacci 2 = 1
tribonacci 3 = 1
tribonacci n = tribonacci (n - 1) + tribonacci (n - 2) + tribonacci (n - 3)
 
binomial :: Integer -> Integer -> Integer
binomial n 0 = 1
binomial 0 n = 0
binomial n k = binomial (n - 1) k + binomial (n - 1) k - 1


suma1n :: Integer -> Integer
suma1n 0 = 0
suma1n n = n + suma1n (n - 1)

putere x 0 = 1
putere x y = x * putere (x - 1) y


inmultire x 1 = x
inmultire x y = x + inmultire x (y - 1)


cifre x 
	| x < 10 = x
	| otherwise = x `mod` 10 + cifre (x `div` 10)