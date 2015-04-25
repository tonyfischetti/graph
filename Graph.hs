module Graph where


import qualified Data.Map as M

-- import Data.Char
-- import Data.List


------------------
----   Node   ----
------------------
data Node = Node {name :: String, attributes :: M.Map String String}

instance Show Node where
        show (Node name attrs) = "    <Node name=\"" ++ name ++ "\">"

instance Eq Node where
        x == y = (name x) == (name y)


-- returns Node with empty attribute map
qnode :: String -> Node
qnode s = Node s M.empty





-- -- a node is just a string
-- type Node = String
-- type Weight = Int
-- type Index = Int
--
-- data Edge = Edge {fromIndex :: Index,
--                   toIndex :: Index,
--                   weight :: Weight} deriving (Show)
--
-- data Graph = Graph {nodes :: [Node], edges :: [Edge]}
--
-- instance Show Graph where
--         show (Graph nodes edges) =
--             "Nodes:\n" ++ 
--             unlines (map (\x -> "    " ++ x) nodes) ++
--             "\nEdges:\n" ++
--             (unlines (map (\x -> "    " ++ x)
--                      (map (\(Edge x y z) -> (nodes !! x) ++
--                                             " -> " ++ (nodes !! y)) edges)))
--
--
--
--
--
-- removeAt :: Int -> [a] -> [a]
-- removeAt i xs = ((init (fst splitted)) ++ (snd splitted))
--     where splitted = splitAt (i+1) xs
--
-- ---------------------
-- ---- Edge things ----
-- ---------------------
-- findEdge :: Node -> Node -> Graph -> Maybe Int
-- findEdge from to graph = findIndex (\(Edge x y _) -> x == (getIndex from graph) &&
--                                                      y == (getIndex to graph))
--                                                      (edges graph)
--
-- addEdge :: Node -> Node -> Weight -> Graph -> Graph
-- addEdge from to weight graph = case findEdge from to graph of
--     Nothing -> Graph (nodes graph) (newEdge : (edges graph)) 
--     _       -> error "edge already exists"
--     where newEdge = (Edge (getIndex from graph) (getIndex to graph) weight)
--
-- removeEdge :: Node -> Node -> Graph -> Graph
-- removeEdge from to graph = case findEdge from to graph of
--     Nothing -> error "edge doesn't exist"
--     Just n  -> Graph (nodes graph) $ removeAt n $ edges graph
--     
--
--
--
-- ---------------------
-- ---- Node things ----
-- ---------------------
-- getIndex :: Node -> Graph -> Index
-- getIndex node graph = case findNode node graph of
--                           Just i  -> i
--                           Nothing -> error $ "no such node: " ++ node
--                           --
-- findNode :: Node -> Graph -> Maybe Int
-- findNode node = elemIndex node . nodes
--
-- addNode :: Node -> Graph -> Graph
-- addNode node graph = Graph (nodes graph ++ [node]) (edges graph)
--
--
-- removeNode :: Node -> Graph -> Graph
-- removeNode node graph = Graph (removeAt (getIndex node graph) (nodes graph)) (edges graph)
