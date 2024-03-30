f list = 
  let
    rev_list = reverse list
    f' (_:x:_) = x
  in
    f' rev_list
