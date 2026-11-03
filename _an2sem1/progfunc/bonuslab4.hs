step :: Char -> [Char] -> [[Char]]
step _ [] = []
step p (' ' : xs) = (p : xs) : [' ' : rest | rest <- step p xs]
step p (x : xs) = [x : rest | rest <- step p xs]


next :: Char -> [[Char]] -> [[Char]]
next p lst = concat (map (step p) lst)


winingLines = [ [0, 1, 2], [3, 4, 5], [6, 7, 8] 
  , [0, 3, 6], [1, 4, 7], [2, 5, 8]  
  , [0, 4, 8], [2, 4, 6]
  ]


isWinning :: Char -> [Char] -> Bool
isWinning p config = any (\line -> all (\i -> config !! i == p) line) winingLines

win :: Char -> [[Char]] -> [[Char]]
win p lst = filter (isWinning p) lst



otherPlayer :: Char -> Char 
otherPlayer 'X' = '0'
otherPlayer _ = 'X'


isFull :: [Char] -> Bool
isFull board = not (' ' `elem` board)

-- facem o simulare de joc si afisam de cate ori castiga X
simulate :: Char -> [[Char]] -> Int
simulate _ [] = 0
simulate p xs = 
    let 
        allNext = next p xs

        winningConfigs = win p allNext
        nonWinningConfigs = filter (`notElem` winningConfigs) allNext

        ongoingConfigs = filter (\board -> not (isFull board)) nonWinningConfigs

        currentStats = if p /= 'X' then 0
            else length winningConfigs

        -- continuam jocurile neterminate
        futureStats = simulate (otherPlayer p) ongoingConfigs
    in
        currentStats + futureStats