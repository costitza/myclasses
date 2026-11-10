data Orientare = N | NE | E | SE | S | SV | V | NV
  deriving (Show, Eq)

data Turtle = Turtle Int Int Orientare
  deriving (Show, Eq)

data Action = Step | Turn            
  deriving (Show, Eq)

data Command = Do Action | Repeat Int Action 
  deriving (Show, Eq)

rotesteDreapta :: Orientare -> Orientare
rotesteDreapta N  = NE
rotesteDreapta NE = E
rotesteDreapta E  = SE
rotesteDreapta SE = S
rotesteDreapta S  = SV
rotesteDreapta SV = V
rotesteDreapta V  = NV
rotesteDreapta NV = N

executaActiune :: Turtle -> Action -> Turtle
executaActiune (Turtle x y N) Step  = Turtle x (y + 1) N
executaActiune (Turtle x y NE) Step = Turtle (x + 1) (y + 1) NE
executaActiune (Turtle x y E) Step  = Turtle (x + 1) y E
executaActiune (Turtle x y SE) Step = Turtle (x + 1) (y - 1) SE
executaActiune (Turtle x y S) Step  = Turtle x (y - 1) S
executaActiune (Turtle x y SV) Step = Turtle (x - 1) (y - 1) SV
executaActiune (Turtle x y V) Step  = Turtle (x - 1) y V
executaActiune (Turtle x y NV) Step = Turtle (x - 1) (y + 1) NV
executaActiune (Turtle x y o) Turn   = Turtle x y (rotesteDreapta o)

executaComanda :: Turtle -> Command -> Turtle
executaComanda t (Do act) = executaActiune t act
executaComanda t (Repeat 0 act) = t
executaComanda t (Repeat n act) = executaComanda (executaActiune t act) (Repeat (n - 1) act)

getPizza :: Turtle -> [Command] -> Turtle
getPizza t [] = t
getPizza t (x:xs) = getPizza (executaComanda t x) xs