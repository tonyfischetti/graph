module TopoSort (showPath, getBestDifficultyProgression, allTopoSorts,
                difficultyTopoSort) where


import Graph
import Data.List
import Data.Function (on)
import qualified Data.Map as M


------------------
----   Path   ----
------------------
type Path = [Node]

showPath :: Path -> String
showPath = drop 4 . concat . map (\n -> " -> " ++ (name n))
--------------------------------------------



----------------------------------
----   Topo Sort Algorithms   ----
----------------------------------
topoSort :: Graph -> Path
topoSort = reverse . gatherChildless

getChildren :: Node -> Graph -> [Node]
getChildren node g = map (\e -> nodeAtIndex g (toIndex e)) relavantEdges
    where loc = getIndex (name node) g
          relavantEdges = filter (\e -> (fromIndex e) == loc) (edges g)

getChildless :: Graph -> [Node]
getChildless g = filter (\n -> null (getChildren n g)) (nodes g)

gatherChildless :: Graph -> [Node]
gatherChildless g
    | null (nodes g) = []
    | otherwise = firstChildless : (gatherChildless
                                   (removeNodeByName (name firstChildless) g))
    where firstChildless = if null childlessList
                               then error "no topo sort exists"
                               else head childlessList
          childlessList = getChildless g

allTopoSorts :: Graph -> [Path]
allTopoSorts g = if null result
                     then error "no topo sort exists"
                     else map fst result
    where result = gatherAllChildless ([], g)

gatherAllChildless :: (Path, Graph) -> [(Path, Graph)]
gatherAllChildless (ns, g)
    | null (nodes g) = [(ns, g)]
    | otherwise = (map (\n -> ((n:ns), (removeNodeByName (name n) g)))
                   childlessList) >>= gatherAllChildless
    where childlessList = getChildless g
--------------------------------------------





-------------------------------------------
----   Specialized Topo Sort Methods   ----
-------------------------------------------
getDifficulties :: Path -> [Int]
getDifficulties = map (read . (M.findWithDefault "1" "difficulty") .  nattributes)

sumBackwardsSteps :: [Int] -> Int
sumBackwardsSteps diffs = sum $ filter (> 0) $ zipWith (-) (init diffs) (drop 1 diffs)

getBestDifficultyProgression :: [Path] -> Path
getBestDifficultyProgression paths = snd $ head $ sortBy (compare `on` fst) everyPath
    where everyPath = zip (map (sumBackwardsSteps . getDifficulties) paths) paths

difficultyTopoSort :: Graph -> Path
difficultyTopoSort g = getBestDifficultyProgression $ allTopoSorts g
--------------------------------------------
