module Graph (Node(..), qnode, Weight, Index, Edge(..), qedge, Graph(..),
              egraph, addNode, addNodeByName,  addEdgeByNames,
              removeEdgeByNames, removeNodeByName, nodeAtIndex, getIndex)  where


import qualified Data.Map as M
import Data.List


------------------
----   Node   ----
------------------
data Node = Node {name :: String, nattributes :: M.Map String String}

instance Show Node where
        show (Node name attrs) = "    <Node name=\"" ++ name ++ "\">"

-- nodes are equal if name is equal
instance Eq Node where
        x == y = (name x) == (name y)

-- returns Node with empty attribute map
qnode :: String -> Node
qnode s = Node s M.empty
--------------------------------------------


------------------
----   Edge   ----
------------------
type Weight = Double
type Index = Int

data Edge = Edge {fromIndex :: Index,
                  toIndex :: Index,
                  weight :: Weight,
                  eattributes :: M.Map String String}

instance Show Edge where
        show (Edge from to weight attr) = edgeTemplate from to weight

edgeTemplate :: Show a => a -> a -> Weight -> String
edgeTemplate f t w = "    <Edge from=" ++ (show f) ++
                     " to=" ++ (show t) ++ " weight=" ++
                     (show w) ++ ">"

showEdgeWithNames :: Graph -> Edge -> String
showEdgeWithNames g edge@(Edge f t w _) = edgeTemplate (nameAtIndex g f)
                                                       (nameAtIndex g t) w


-- edges are equal if endpoints are equal
instance Eq Edge where
        x == y = (fromIndex x) == (fromIndex y) && (toIndex x) == (toIndex y)

-- returns Edge with empty attribute map
qedge :: Index -> Index -> Weight -> Edge
qedge f t w = Edge f t w M.empty
--------------------------------------------


-------------------
----   Graph   ----
-------------------
data Graph = Graph {nodes :: [Node], edges :: [Edge]}

instance Show Graph where
        show graph@(Graph nodes edges) = "<Graph>\n  <Nodes>\n" ++ 
            (unlines $ map show nodes) ++ "  </Nodes>\n" ++
            "  <Edges>\n" ++
            (unlines . (map (showEdgeWithNames graph))) edges ++
            "  </Edges>\n</Graph>\n"

egraph = Graph [] []
--------------------------------------------






------------------------------
----   Graph Operations   ----
------------------------------
nameAtIndex :: Graph -> Index -> String
nameAtIndex g i = name $ nodeAtIndex g i

nodeAtIndex :: Graph -> Index -> Node
nodeAtIndex g i = (nodes g) !! i

findNode :: Node -> Graph -> Maybe Int
findNode node = elemIndex node . nodes

findEdgeFromNames :: String -> String -> Graph -> Maybe Int
findEdgeFromNames f t g = elemIndex (qedge (whereIs f) (whereIs t) 1) (edges g)
    where whereIs s = getIndex s g

getIndex :: String -> Graph -> Index
getIndex name graph = case findNode (qnode name) graph of
                          Just i  -> i
                          Nothing -> error $ "no such node: " ++ name

addNode :: Node -> Graph -> Graph
addNode node graph
    | any (== node) (nodes graph) = error "node already exists"
    | otherwise                   = Graph (node : (nodes graph)) (edges graph)

addNodeByName :: String -> Graph -> Graph
addNodeByName n g = Graph ((qnode n):(nodes g)) (edges g)


addEdgeByNames :: String -> String -> Weight -> Graph -> Graph
addEdgeByNames f t w g = case findEdgeFromNames f t g of
    Nothing -> Graph (nodes g) (newEdge : (edges g))
    _       -> error "edge already exists"
    where newEdge = (qedge (getIndex f g) (getIndex t g) w)

-- doesn't warn if edge doesn't exist
removeEdgeByNames :: String -> String -> Graph -> Graph
removeEdgeByNames f t g = Graph (nodes g)
                            (filter (/= (qedge (whereIs f) (whereIs t) 1)) (edges g))
    where whereIs s = getIndex s g

removeNodeByName :: String -> Graph -> Graph
removeNodeByName n g = Graph (filter (/= (qnode n)) (nodes g))
                         (map (decrementIfHigherIndex loc)
                              (removeConnectedEdges loc (edges g)))
    where loc = getIndex n g

removeConnectedEdges :: Index -> [Edge] -> [Edge]
removeConnectedEdges i es = filter (not . (connectedTo i)) es

connectedTo :: Index -> Edge -> Bool
connectedTo index edge = (fromIndex edge == index) || (toIndex edge == index)

decrementIfHigherIndex :: Index -> Edge -> Edge
decrementIfHigherIndex i edge@(Edge from to weight attrs) =
        Edge (decIfHigher from) (decIfHigher to) weight attrs
    where decIfHigher j = if j > i then j-1 else j

--------------------------------------------









