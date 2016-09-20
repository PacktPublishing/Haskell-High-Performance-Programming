# Haskell High Performance Programming
This is the code repository for [Haskell High Performance Programming](https://www.packtpub.com/application-development/haskell-high-performance-programming?utm_source=github&utm_medium=repository&utm_campaign=9781786464217) By Packt. It contains all the supporting project files necessary to work through the book from start to finish.

##Instructions and Navigation
All of the code is organized into folders. Each folder starts with number followed by the application name. For example, Chapter02.

You will see code something similler to the following:

```
class Some a where
    next :: a -> a -> a

instance Some Double where
    next a b = (a + b) / 2

goGeneral :: Some a => Int -> a -> a
goGeneral 0 x = x
goGeneral n x = goGeneral (n-1) (next x x)

```

Software and Hardware List

| Chapter  | Software required   | OS required |
| -------- | ------------------- | ------------|
| 1 to 14  | GHC >= 7.6          | Windows     |
|    4     | Haskell  Stack tool | Windows     |
|   11     | CUDA-enabled system | Windows     |



##Related Haskell Products:
[Haskell Data Analysis Cookbook](https://www.packtpub.com/big-data-and-business-intelligence/haskell-data-analysis-cookbook?utm_source=github&utm_medium=repository&utm_campaign=9781783286331)

[Haskell Design Patterns](https://www.packtpub.com/application-development/haskell-design-patterns?utm_source=github&utm_medium=repository&utm_campaign=9781783988723)

[Learning Haskell Data Analysis](https://www.packtpub.com/big-data-and-business-intelligence/learning-haskell-data-analysis?utm_source=github&utm_medium=repository&utm_campaign=9781784394707)






### Suggestions and Feedback
[Click here] (https://docs.google.com/forms/d/e/1FAIpQLSe5qwunkGf6PUvzPirPDtuy1Du5Rlzew23UBp2S-P3wB-GcwQ/viewform) if you have any feedback or suggestions.
