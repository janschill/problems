f::Eq a=>[a]->Bool
f list =
  let
    half = div (length list) 2
    front = take half list
    back = take half (reverse list)
  in
    front == back
