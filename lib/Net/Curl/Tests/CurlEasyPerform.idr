module Net.Curl.Tests.CurlEasyPerform
import Net.Curl
import Net.Curl.Definitions
import Control.Monad.State
import Language.JSON.Tokens
import Language.JSON.Data

checkCurlEasyPerform : (CurlResult, CurlState) -> IO()
checkCurlEasyPerform (result, CurrentState(call_stack, _, _)) = do
  case result of
    CurlResultJSON res => printLn(res)
    CurlResultError str => printLn("curlEasyPerform >>> Failed:" ++ str)
    _ => printLn("curlEasyPerform >>> Failed: Unexpected Type Returned")

runCurlEasyPerform: State CurlState CurlResult
runCurlEasyPerform = do
  init
  setURL "http://www.json-generator.com/api/json/get/ceGtYhIQoi?indent=2"
  curlEasyPerform

export
test: IO()
test = checkCurlEasyPerform (runState runCurlEasyPerform (initialState DebugModeOn))
