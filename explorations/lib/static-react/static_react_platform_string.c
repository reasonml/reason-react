/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#define CAML_NAME_SPACE
            
/**
 * The C-99 encodings of the raw macro string, which the linker will search
 * for. Using the implementation of OCaml's string length.
 * Note: for some reason these don't work unless using CAMLprim
 */

#define LEN raw$2dmacro$3a$3c$40js$3e$3c$401$2f$3e$2elength$3c$2f$40js$3e$3c$40php$3eStr$5clength$28$3c$401$2f$3e$29$3c$40$2fphp$3e

#define CONCAT raw$2dmacro$3a$3c$40js$3e$3c$401$2f$3e$2b$3c$402$2f$3e$3c$2f$40js$3e$3c$40php$3e$3c$401$2f$3e$2e$3c$402$2f$3e

#define CHARCODEAT raw$2dmacro$3a$3c$40js$3e$3c$401$2f$3e$2echarCodeAt$28$3c$402$2f$3e$29$3c$2f$40js$3e$3c$40php$3ePHP$5cord$28$3c$401$3e$5b$3c$402$2f$3e$5d$29$3c$40$2fphp$3e

#define SUB raw$2dmacro$3a$3c$40js$3e$3c$401$2f$3e$2esubstring$28$3c$402$2f$3e$2c$20$3c$403$2f$3e$29$3c$2f$40js$3e$3c$40php$3ePHP$5csubstr$28$3c$401$2f$3e$2c$20$3c$402$2f$3e$2c$20$3c$402$2f$3e$20$3e$20$3c$403$2f$3e$20$3f$200$20$3a$20$3c$403$2f$3e$2d$3c$402$2f$3e$29$3c$2f$40php$3e

#include <stdio.h>
#include <string.h>
#include <caml/fail.h>

#include <caml/mlvalues.h>
#include <caml/memory.h>
#include <caml/alloc.h>

/**
 * Nice overview: https://www.linux-nantes.org/~fmonnier/OCaml/ocaml-wrapping-c.html
 *
 * See "Notice that here it is possible not to use CAMLparam/CAMLreturn even if
 * there is an ocaml alloc, because there aren't any ocaml values used *after*
 * the ocaml alloc. In your code if there are some, do put the
 * CAMLparam/CAMLreturn !"
 *
 * "It goes a bit different for floats and strings than ints, since these types
 * have to be allocated for OCaml, and one thing important to know in OCaml is
 * that when an allocation is done (a new value created), a garbage collection
 * may be done. If the allocation is given at the end point in the C return
 * statement, all is fine. But notice that in other cases which will be seen
 * below, additional statements have to be used."
 *
 * Regarding CAMLparam/CAMLlocal:
 * "When you are not sure if you need to use these macro or not, it's better to
 * use these to stay in peace with the garbage collector, since using these
 * macros won't cause problems, even if they are not needed. That's why you
 * will see below cases where they are used while not strictly needed.
 * Moreover, a lot of OCaml users recommend always using these to avoid the
 * risk of forgetting to use them when they are needed."
 */

CAMLexport mlsize_t LEN(value s)
{
  mlsize_t temp;
  temp = Bosize_val(s) - 1;
  CAMLassert (Byte (s, temp - Byte (s, temp)) == 0);
  // ocaml stdlib uses Val_long here. Not clear what the diff is.
  // The docs say they both compute ints.
  return Val_long(temp - Byte (s, temp));
}


/**
 * "On the OCaml side, strings are able to handle any character, included the
 * possible '\000', but if you use caml_copy_string() to copy the raw data it
 * will end at the first Null character, because it considers it as the string
 * terminator.  So you should use caml_alloc_string() and memcpy():"
 */
CAMLprim value CONCAT(value s1, value s2)
{
  CAMLparam2(s1, s2);
  char *cs1;
  char *cs2;
  int s1len = caml_string_length(s1);
  int s2len = caml_string_length(s2);
  CAMLlocal1(ml_data);
  ml_data = caml_alloc_string(s1len + s2len);
  cs1 = String_val(s1);
  cs2 = String_val(s2);
  char* ml_data_chararray = String_val(ml_data);
  memcpy((char *)ml_data_chararray, cs1, s1len); // s1len won't copy null term
  memcpy((char *)ml_data_chararray + s1len, cs2, s2len); // Won't copy over null term
  // CAMLreturn just to be safe though the tutorial linked says we don't have
  // to in this case.
  mlsize_t temp;
  temp = Bosize_val(ml_data) - 1;
  CAMLassert (Byte (ml_data, temp - Byte (ml_data, temp)) == 0);
  CAMLreturn(ml_data);
}

CAMLprim value SUB(value s, value start, value one_plus_end)
{
  CAMLparam3(s, start, one_plus_end);
  int one_plus_end_int = Long_val(one_plus_end);
  int start_int = Long_val(start);
  int slen = caml_string_length(s);
  if(one_plus_end_int > slen) {
    caml_invalid_argument("Platform string sub(s, start, end_plus_one) called with end_plus_one > length");
  }
  if(start_int >= one_plus_end_int) {
    CAMLreturn(caml_alloc_string(0));
  }
  CAMLlocal1(ml_data);
  ml_data = caml_alloc_string(one_plus_end_int - start_int);
  const char *cs;
  cs = String_val(s);
  memcpy((char *)String_val(ml_data), cs + start_int, one_plus_end_int - start_int);
  CAMLreturn(ml_data);
}

CAMLprim value CHARCODEAT(value s, value atInt)
{
  CAMLparam2(s, atInt);
  int at;
  at = Long_val(atInt);
  int ret = Byte(s, at);
  CAMLreturn(Val_int(ret));
}


/**
 * fromPlatformString
 */
CAMLprim value caml_js_to_string(value bv)
{
  return bv;
}


/**
 * toPlatformString
 */
CAMLprim value caml_js_from_string(value bv)
{
  return bv;
}
/*  caml_js_from_string */
/*  caml_js_to_string */
/*  raw$2dmacro$3a$3c$40js$3e$3c$401$2f$3e$20$2b$20$3c$402$2f$3e$3c$2f$40js$3e */
/*  raw$2dmacro$3a$3c$40js$3e$3c$401$2f$3e$2echarCodeAt$28$3c$402$2f$3e$29$3c$2f$40js$3e */
/*  raw$2dmacro$3a$3c$40js$3e$3c$401$2f$3e$2elength$3c$2f$40js$3e */
/*  raw$2dmacro$3a$3c$40js$3e$3c$401$2f$3e$2esubstring$28$3c$402$2f$3e$2c$20$3c$403$2f$3e$29$3c$2f$40js$3e */
/* ** Cannot resolve symbols for lib/react-lib/ReactLib.a(reactLib__ReactDOMUtils.o/ */
/* reactLib__ReactDOM.o/ */
/* reactLib__Event.o/ */

/* ): */
/*  caml_js_from_string */
/*  caml_js_to_string */
/*  raw$2dmacro$3a$3c$40js$3e$22$22$3c$2f$40js$3e */
/*  raw$2dmacro$3a$3c$40js$3e$3c$401$2f$3e$20$2b$20$3c$402$2f$3e$3c$2f$40js$3e */
/*  raw$2dmacro$3a$3c$40js$3e$3c$401$2f$3e$2echarCodeAt$28$3c$402$2f$3e$29$3c$2f$40js$3e */
/*  raw$2dmacro$3a$3c$40js$3e$3c$401$2f$3e$2elength$3c$2f$40js$3e */
/*  raw$2dmacro$3a$3c$40js$3e$3c$401$2f$3e$2esubstring$28$3c$402$2f$3e$2c$20$3c$403$2f$3e$29$3c$2f$40js$3e */
/* File "caml_startup", line 1: */
/* Error: Error during linking */
/* error: command failed: "refmterr" "dune" "build" "@install" "-p" "static-react" (exited with 1) */
/* esy-build-package: exiting with errors above... */
/* error: build failed with exit code: 1 */

/* esy: exiting due to errors above */



/* [> returns a number of bytes (chars) <] */
/* CAMLexport mlsize_t caml_string_length(value s) */
/* { */
/*   mlsize_t temp; */
/*   temp = Bosize_val(s) - 1; */
/*   CAMLassert (Byte (s, temp - Byte (s, temp)) == 0); */
/*   return temp - Byte (s, temp); */
/* } */


/* CAMLprim value native_out(value str) */
/* { */
/*   CAMLparam1(str); */
/*   printf("%s", String_val(str)); */
/*   CAMLreturn(Val_unit); */
/* } */

/* CAMLprim value native_log(value str) */
/* { */
/*   CAMLparam1(str); */
/*   printf("%s\n", String_val(str)); */
/*   CAMLreturn(Val_unit); */
/* } */

/* CAMLprim value native_debug(value str) */
/* { */
/*   CAMLparam1(str); */
/*   printf("%s\n", String_val(str)); */
/*   CAMLreturn(Val_unit); */
/* } */

/* CAMLprim value native_error(value str) */
/* { */
/*   CAMLparam1(str); */
/*   fprintf(stderr, "%s\n", String_val(str)); */
/*   CAMLreturn(Val_unit); */
/* } */

/* CAMLprim value native_warn(value str) */
/* { */
/*   CAMLparam1(str); */
/*   fprintf(stderr, "%s\n", String_val(str)); */
/*   CAMLreturn(Val_unit); */
/* } */
