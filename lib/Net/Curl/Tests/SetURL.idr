module Net.Curl.Tests
import Net.Curl
import Net.Curl.Definitions
import Control.Monad.State

check : (CurlResult, CurlState) -> IO ()
check (result, CurrentState(call_stack, _, _)) = do
  case result of
    CurlResultSuccess => printLn("setURL >>> Ok!")
    CurlResultError str => printLn("setURL >>> Failed:" ++ str)
    _ => printLn("setURL >>> Failed: Unexpected Type Returned")

feature : State CurlState CurlResult
feature = do
  init
  setURL "http://www.json-generator.com/api/json/get/ceGtYhIQoi?indent=2"

export
setURL : IO()
setURL = check (runState feature (initialState DebugModeOn))
