module Net.Curl.Tests.Init
import Net.Curl
import Net.Curl.Definitions
import Control.Monad.State

checkInit : (CurlResult, CurlState) -> IO()
checkInit (result, state) =
  case result of
    CurlResultSuccess => printLn("init >>> Ok!")
    CurlResultError str => printLn("init >>> Failed:" ++ str)
    _ => printLn("init >>> Failed: Unexpected Type Returned")


runInit: State CurlState CurlResult
runInit = init

export
test : IO()
test = checkInit (runState runInit (initialState DebugModeOn))
