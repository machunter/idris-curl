module Net.Curl.Tests.EnableNetRCFile
import Net.Curl
import Net.Curl.Definitions
import Control.Monad.State

check : (CurlResult, CurlState) -> IO()
check (result, state) =
  case result of
    CurlResultSuccess => printLn("enableNetRCFile >>> Ok!")
    CurlResultError str => printLn("enableNetRCFile >>> Failed:" ++ str)
    _ => printLn("enableNetRCFile >>> Failed: Unexpected Type Returned")


feature: State CurlState CurlResult
feature = do
  init
  enableNetRCFile

export
test : IO()
test = check (runState feature (initialState DebugModeOn))
