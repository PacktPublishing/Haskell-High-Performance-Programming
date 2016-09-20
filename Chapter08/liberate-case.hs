-- file: liberate-case.hs

option = ('a', 'b')

-- fun x = case option of
--             (a, _) -> a : fun x

fun x = case option of
            (a, _) -> a : (let f x' = a : f x' in f x)
                        
