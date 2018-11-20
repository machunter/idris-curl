module Net.Curl.Tests.EasyPerform
import Net.Curl
import Net.Curl.Definitions
import Control.Monad.State
import Language.JSON.Tokens
import Language.JSON.Data

check : (CurlResult, CurlState) -> IO()
check (result, CurrentState(call_stack, _, _)) = do
  case result of
    CurlResultJSON res => printLn("curlEasyPerform >>> Ok!")
    CurlResultError str => printLn("curlEasyPerform >>> Failed:" ++ str)
    _ => printLn("curlEasyPerform >>> Failed: Unexpected Type Returned")

feature: State CurlState CurlResult
feature = do
  init
  setURL "http://www.json-generator.com/api/json/get/ceGtYhIQoi?indent=2"
  easyPerform

export
test: IO()
test = check (runState feature (initialState DebugModeOn))
