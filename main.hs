

import Graph
import TopoSort
import Data.Function (on)
import Data.List (sortBy)
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



mySimpleGraph = egraph |>
    addNodeByName "alpha" |>
    addNodeByName "beta" |>
    addNodeByName "gamma" |>
    addNodeByName "delta" |>
    addNodeByName "epsilon" |>
    addEdgeByNames "alpha" "beta" 1 |>
    addEdgeByNames "alpha" "gamma" 1 |>
    addEdgeByNames "beta" "delta" 1 |>
    addEdgeByNames "gamma" "epsilon" 1


mySimpleGraph2 = egraph |>
    addNode (Node "alpha" $ M.fromList [("difficulty", "1")]) |>
    addNode (Node "beta" $ M.fromList [("difficulty", "2")]) |>
    addNode (Node "gamma" $ M.fromList [("difficulty", "3")]) |>
    addNode (Node "delta" $ M.fromList [("difficulty", "6")]) |>
    addNode (Node "epsilon" $ M.fromList [("difficulty", "4")]) |>
    addEdgeByNames "alpha" "beta" 1 |>
    addEdgeByNames "alpha" "gamma" 1 |>
    addEdgeByNames "beta" "delta" 1 |>
    addEdgeByNames "gamma" "epsilon" 1



actualGraph = egraph |>
    addNode (Node "central tendency" $ M.fromList [("difficulty", "1")]) |>
    addNode (Node "measures of dispersion" $ M.fromList [("difficulty", "2")]) |>
    addNode (Node "sampling theory" $ M.fromList [("difficulty", "3")]) |>
    addNode (Node "sampling distributions" $ M.fromList [("difficulty", "3")]) |>
    addNode (Node "central limit theorem" $ M.fromList [("difficulty", "5")]) |>
    addNode (Node "probability" $ M.fromList [("difficulty", "4")]) |>
    addNode (Node "probability distributions" $ M.fromList [("difficulty", "3")]) |>
    addNode (Node "statistical inference" $ M.fromList [("difficulty", "5")]) |>
    addNode (Node "NHST" $ M.fromList [("difficulty", "5")]) |>
    addEdgeByNames "central tendency" "measures of dispersion" 7 |>
    addEdgeByNames "central tendency" "sampling theory" 5 |>
    addEdgeByNames "measures of dispersion" "sampling theory" 5 |>
    addEdgeByNames "sampling theory" "sampling distributions" 7 |>
    addEdgeByNames "sampling theory" "statistical inference" 5 |>
    addEdgeByNames "sampling distributions" "statistical inference" 8 |>
    addEdgeByNames "sampling distributions" "central limit theorem" 8 |>
    addEdgeByNames "probability" "sampling distributions" 7 |>
    addEdgeByNames "probability" "probability distributions" 8 |>
    addEdgeByNames "probability" "central limit theorem" 2 |>
    addEdgeByNames "probability" "statistical inference" 9 |>
    addEdgeByNames "central limit theorem" "statistical inference" 3 |>
    addEdgeByNames "statistical inference" "NHST" 9


main = do
        print $ showPath $ difficultyTopoSort actualGraph



-- main = mapM print $ map showPath $ allTopoSorts mySimpleGraph2
