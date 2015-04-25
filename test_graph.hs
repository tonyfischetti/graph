
import Test.HUnit
import System.Exit (ExitCode(..), exitWith)
import qualified Data.Map as M
import Graph


testCase :: String -> Assertion -> Test
testCase label assertion = TestLabel label (TestCase assertion)

exitProperly :: IO Counts -> IO ()
exitProperly m = do
  counts <- m
  exitWith $ if failures counts /= 0 || errors counts /= 0 then ExitFailure 1 else ExitSuccess


main :: IO ()
main = exitProperly $ runTestTT $ TestList [TestList graphTests]

graphTests :: [Test]
graphTests =
        [
        testCase "nodes with different names are unequal" $ do
            False @=? qnode "morrissey" == qnode "johnny",
        testCase "nodes with same name are equal" $ do
            True @=? qnode "andy" == Node "andy" M.empty,
        testCase "nodes display right" $ do
            "    <Node name=\"mike\">" @=? show (qnode "mike"),
        testCase "edges with different names are unequal" $ do
            False @=? qedge 4 2 0.1 == qedge 4 1 0.2,
        testCase "edges with same name are equal" $ do
            True @=? qedge 4 2 0.1 == Edge 4 2 0.2 M.empty,
        testCase "edges display right" $ do
            "    <Edge from=4 to=2 weight=1.0>" @=? show (qedge 4 2 1),
        testCase "graph displays right" $ do
            (unlines ["<Graph>", "  <Nodes>", "    <Node name=\"this\">",
                      "    <Node name=\"that\">",
                      "    <Node name=\"theother\">", "  </Nodes>",
                      "  <Edges>",
                      "    <Edge from=\"this\" to=\"that\" weight=1.0>",
                      "    <Edge from=\"that\" to=\"theother\" weight=1.0>",
                      "  </Edges>", "</Graph>"]) @=?  show
                      (Graph [(qnode "this"), (qnode "that"), (qnode "theother")]
                      [(qedge 0 1 1), (qedge 1 2 1)])
        ]
