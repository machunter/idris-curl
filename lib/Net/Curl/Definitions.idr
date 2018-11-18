module Net.Curl.Definitions
import Language.JSON
import Language.JSON.Tokens

public export
CallTrace : Type
CallTrace = List String

public export
data DebugMode = DebugModeOn | DebugModeOff

public export
data CurlResultCode =
  CurlEasyOk |
  CurlEasyUnsupportedProtocol |
  CurlEasyFailedInit |
  CurlEasyUrlMalFormat |
  CurlGenericError Int

public export
data CurlHandle =   MkHandle Ptr

public export
data CurlResult =
    CurlResultSuccess |
    CurlResultError String |
    CurlResultInteger Integer |
    CurlResultBool Bool |
    CurlResultPtr Ptr |
    CurlResultString String |
    CurlResultVoid |
    CurlResultJSON JSON

public export
data CurlState = CurrentState (CallTrace, Maybe CurlHandle, Maybe CurlResult, DebugMode)
