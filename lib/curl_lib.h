#include <stdlib.h>
#include <string.h>
#include <curl/curl.h>

CURL* curlEasyInit();
// CURLcode  curlEasyCleanup(CURL* handle);
CURLcode  curlEasySetURL(CURL* handle, const char *url);
char*  curlEasyPerform(CURL* handle);
CURLcode curlEnableNetRCFile(CURL* handle);
