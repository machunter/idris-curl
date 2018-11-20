#include  "curl_lib.h"

struct MemoryStruct {
  char *memory;
  size_t size;
};

static size_t WriteMemoryCallback(void *contents, size_t size, size_t nmemb, void *userp)
{
  size_t realsize = size * nmemb;
  struct MemoryStruct *mem = (struct MemoryStruct *)userp;

  char *ptr = realloc(mem->memory, mem->size + realsize + 1);
  if(ptr == NULL) {
    /* out of memory! */
    printf("not enough memory (realloc returned NULL)\n");
    return 0;
  }

  mem->memory = ptr;
  memcpy(&(mem->memory[mem->size]), contents, realsize);
  mem->size += realsize;
  mem->memory[mem->size] = 0;

  return realsize;
}


CURL* curlEasyInit() {
  CURL *curl = curl_easy_init();
#ifdef LOGCCALLS
  printf ("curlEasyInit: %p\n", curl);
#endif
  return curl;
}

CURLcode  curlEasySetURL(CURL* handle, const char *url) {
  CURLcode res;
  res = curl_easy_setopt(handle, CURLOPT_URL, url);
#ifdef LOGCCALLS
  printf ("curlEasySetURL: %i\n", res);
#endif
  return res;
}

CURLcode curlEnableNetRCFile(CURL* handle) {
  CURLcode res;
  res = curl_easy_setopt(handle, CURLOPT_NETRC, CURL_NETRC_REQUIRED);
#ifdef LOGCCALLS
  printf ("curlEasySetURL: %i\n", res);
#endif
  return res;

}

char*  curlEasyPerform(CURL* handle) {
  struct MemoryStruct chunk;

  chunk.memory = malloc(1);  /* will be grown as needed by the realloc above */
  chunk.size = 0;

  curl_easy_setopt(handle, CURLOPT_WRITEFUNCTION, WriteMemoryCallback); // Passing the function pointer to LC
  curl_easy_setopt(handle, CURLOPT_WRITEDATA, (void*) &chunk); // Passing our BufferStruct to LC
  // should decide what to do with a failure
  curl_easy_perform( handle );
#ifdef LOGCCALLS
  printf("curlEasyPerform >>> %s", (char*) chunk.memory);
#endif
  return chunk.memory;
}
