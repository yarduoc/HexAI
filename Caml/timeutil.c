// vim: ft=c
#include </usr/local/lib/caml-light/mlvalues.h>
#include </usr/local/lib/caml-light/alloc.h>
#include <time.h>

value avoirTemp(value unit)
{
    return copy_double(((double) clock()) / CLOCKS_PER_SEC);
}
