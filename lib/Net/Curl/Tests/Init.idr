module Net.Curl.Tests
import Net.Curl
import Net.Curl.Definitions
import Control.Monad.State

check : (CurlResult, CurlState) -> IO()
check (result, state) =
  case result of
    CurlResultSuccess => printLn("init >>> Ok!")
    CurlResultError str => printLn("init >>> Failed:" ++ str)
    _ => printLn("init >>> Failed: Unexpected Type Returned")


feature: State CurlState CurlResult
feature = init

export
init : IO()
init = check (runState feature (initialState DebugModeOn))
