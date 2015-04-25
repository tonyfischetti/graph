
import Graph
import Data.Map


(|>) x f = f x


main = Graph [(qnode "b"), (qnode "c"), (qnode "d")] [] |>
        addNode (qnode "a") |>
        addEdgeByNames "a" "b" 1 |>
        addEdgeByNames "b" "c" 1 |>
        addEdgeByNames "c" "d" 1 |>
        addEdgeByNames "d" "a" 1 |>
        removeNodeByName "d" |>
        print
      


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
