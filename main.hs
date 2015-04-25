
import Graph
import Data.Map


(|>) x f = f x


main = print $ (Node "hi" empty) == (Node "hi" (fromList [("key", "value")]))
      


-- main = print $ foldl (flip addNode) graph (reverse ["theta", "eta", "zeta",
--                                                   "epsilon", "delta", "gamma",
--                                                   "beta", "alpha"]) |>
--                 addEdge "alpha" "beta" 10 |>
--                 addEdge "beta" "gamma" 4 |>
--                 addEdge "gamma" "delta" 5 |>
--                 addEdge "delta" "epsilon" 5 |>
--                 addEdge "epsilon" "zeta" 5 |>
--                 addNode "omega" |>
--                 removeNode "delta"
