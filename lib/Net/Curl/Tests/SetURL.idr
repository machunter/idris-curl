module Net.Curl.Tests.SetURL
import Net.Curl
import Net.Curl.Definitions
import Control.Monad.State

checkSetURL : (CurlResult, CurlState) -> IO ()
checkSetURL (result, CurrentState(call_stack, _, _)) = do
  case result of
    CurlResultSuccess => printLn("set_url >>> Ok!")
    CurlResultError str => printLn("set_url >>> Failed:" ++ str)
    _ => printLn("set_url >>> Failed: Unexpected Type Returned")

runSetURL : State CurlState CurlResult
runSetURL = do
  init
  setURL "http://www.json-generator.com/api/json/get/ceGtYhIQoi?indent=2"

export
test : IO()
test = checkSetURL (runState runSetURL (initialState DebugModeOn))
