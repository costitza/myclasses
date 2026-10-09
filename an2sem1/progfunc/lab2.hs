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
 
 
 
eeny :: Integer -> String
eeny = undefined
 
fizzbuzz :: Integer -> String
fizzbuzz = undefined
 
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
tribonacci = undefined
 
binomial :: Integer -> Integer -> Integer
binomial = undefined