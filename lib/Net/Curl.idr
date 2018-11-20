module Net.Curl
import CFFI
import Net.Curl.CImports as Imports
import Net.Curl.Definitions
import Control.Monad.State

public export
initialState : DebugMode -> CurlState
initialState DebugModeOn = CurrentState (["start"], Nothing, Nothing, DebugModeOn)
initialState DebugModeOff = CurrentState (["start"], Nothing, Nothing, DebugModeOn)

public export
init : State CurlState CurlResult
init = do
  CurrentState (last_state, _, _, debugMode) <- get
  let result = init
  put (CurrentState("init"::last_state, result, Just CurlResultSuccess, debugMode))
  pure (CurlResultSuccess)

public export
setURL : String -> State CurlState CurlResult
setURL url = do
  CurrentState (last_state, Just handle, _, debugMode) <- get
  let result = (easy_set_url handle url)
  put (CurrentState("setURL"::last_state, Just handle, Just CurlResultSuccess, debugMode))
  pure (result)


public export
easyPerform : State CurlState CurlResult
easyPerform = do
  CurrentState (last_state, Just handle, _, debugMode) <- get
  let result = curlEasyPerform handle
  put (CurrentState("curlEasyPerfrom"::last_state, Just handle, Just CurlResultSuccess, debugMode))
  pure (result)

public export
enableNetRCFile : State CurlState CurlResult
enableNetRCFile = do
  CurrentState (last_state, Just handle, _, debugMode) <- get
  let result = curlEnableNetRCFile handle
  put (CurrentState ("curlEnableNetRCFile"::last_state, Just handle, Just CurlResultSuccess, debugMode))
  pure result
