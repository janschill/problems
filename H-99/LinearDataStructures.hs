module LinearDataStructures where

data Stack a = End | Node a (Stack a)

instance Show a => Show (Stack a) where
  show End = "."
  show (Node a stack) = (show a) ++ " " ++ (show stack)

instance Num a => Num (Stack a) where
  (+) End End   = End
  (+) End stack = stack
  (+) stack End = stack
  (+) (Node a1 stack1) (Node a2 stack2) = Node (a1 + a2) (stack1 + stack2)

s1 = Node 1 (Node 2 (Node 5 (Node 10 (End))))
s2 = Node '1' (Node '2' (Node '5' (Node '3' (End))))
s3 = Node True (Node True (Node False (Node True (End))))
s4 = Node True (Node True (Node False (Node True (End))))

class StackOperations a where
  push::a->(Stack a)->(Stack a)
  pop::(Stack a)->(Stack a)
  peek::(Stack a)->a
  empty::(Stack a)->Bool
  size::(Stack a)->Int

instance  StackOperations Integer where
  push element stack = Node element stack

  pop End = End
  pop (Node _ stack) = stack

  peek End = error "empty stack"
  peek (Node element _) = element

  empty End = True
  empty _ = False

  size End = 0
  size (Node _ stack) = 1 + (size stack)
