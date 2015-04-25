
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


otherGraph = egraph |>
               addNodeByName "beta" |>
               addNodeByName "omega" |>
               addNodeByName "alpha" |>
               addNodeByName "gamma" |>
               addEdgeByNames "gamma" "omega" 1 |>
               addEdgeByNames "beta" "alpha" 1 |>
               addEdgeByNames "beta" "gamma" 1 |>
               addEdgeByNames "omega" "alpha" 1

simpleGraph = egraph |>
                addNodeByName "central tendency" |>
                addNodeByName "measures of dispersion" |>
                addNodeByName "sampling theory" |>
                addEdgeByNames "central tendency" "measures of dispersion" 7 |>
                addEdgeByNames "measures of dispersion" "sampling theory" 8 |>
                addEdgeByNames "central tendency" "sampling theory" 8

nonDAGSimpleGraph = egraph |>
                      addNodeByName "central tendency" |>
                      addNodeByName "measures of dispersion" |>
                      addNodeByName "sampling theory" |>
                      addEdgeByNames "central tendency" "measures of dispersion" 7 |>
                      addEdgeByNames "measures of dispersion" "sampling theory" 8 |>
                      addEdgeByNames "central tendency" "sampling theory" 8 |>
                      addEdgeByNames "sampling theory" "measures of dispersion" 1



main = nonDAGSimpleGraph |> topoSort |> print
