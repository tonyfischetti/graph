
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
            "    <Node name=\"mike\">" @=? show (qnode "mike")
        ]
