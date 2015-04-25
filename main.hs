
import Graph
import qualified Data.Map as M


(|>) x f = f x



myGraph = foldl (flip addNodeByName) egraph
             (reverse ["theta", "eta", "zeta",
                       "epsilon", "delta", "gamma",
                       "beta", "alpha"]) |>
                addEdgeByNames "alpha" "delta" 1 |>
                addEdgeByNames "beta" "delta" 2 |>
                addEdgeByNames "gamma" "epsilon" 3 |>
                addEdgeByNames "delta" "zeta" 4 |>
                addEdgeByNames "delta" "eta" 5 |>
                addEdgeByNames "delta" "theta" 6 |>
                addEdgeByNames "epsilon" "eta" 7 |>
                addEdgeByNames "gamma" "theta" 8


main = print $ topoSort myGraph
