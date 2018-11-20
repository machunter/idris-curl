module Net.Curl.CImports
import Net.Curl.Definitions
import Language.JSON.Lexer
import Language.JSON.Parser
import Language.JSON

%lib      C "curl"
%link     C "curl_lib.o"
%include  C "curl_lib.h"

public export
getCurlError : Int -> CurlResultCode
getCurlError code =
  case code of
    1 => CurlEasyUnsupportedProtocol
    2 => CurlEasyFailedInit
    3 => CurlEasyUrlMalFormat
    _ =>  CurlGenericError code

public export
init : Maybe CurlHandle
init =
  let
    result = unsafePerformIO (foreign FFI_C "curlEasyInit" (IO Ptr))
  in
    if result == null
      then Nothing
      else Just (MkHandle result)

public export
easy_set_url : CurlHandle -> String -> CurlResult
easy_set_url (MkHandle handle) url =
  let
    result = unsafePerformIO (foreign FFI_C "curlEasySetURL" (Ptr -> String -> IO Int) handle url)
  in
    if (result == 0)
      then CurlResultSuccess
      else CurlResultError "C call on curlEasySetURL failed!"

public export
curlEasyPerform : CurlHandle -> CurlResult
curlEasyPerform (MkHandle handle) =
  let
    result = unsafePerformIO (foreign FFI_C "curlEasyPerform" (Ptr -> IO String) handle)
  in
    if ((length result) == 0)
      then CurlResultError "C call on curlEasyPerform failed!"
      else let lexJSONResult = lexJSON result in
        case lexJSONResult of
          Just jsonTokensList => let jsonObject = parseJSON jsonTokensList in
            case jsonObject of
              Just jsonObject => CurlResultJSON jsonObject
              Nothing => CurlResultError "Couldn't parse JSON object"
          Nothing => CurlResultError "Not JSON!"

public export
curlEnableNetRCFile : CurlHandle -> CurlResult
curlEnableNetRCFile (MkHandle handle) =
  let
    result = unsafePerformIO (foreign FFI_C "curlEnableNetRCFile" (Ptr -> IO Int) handle)
  in
    if result == 0
      then CurlResultSuccess
      else CurlResultError "Couldn't set CURLOPT_NETRC flag"
