(*
** For writing ATS code
** that translates into Python
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2pypre_"
#define
ATS_STATIC_PREFIX "_ats2pypre_array_"
//
(* ****** ****** *)

%{^
######
#
from ats2pypre_basics_cats import *
#
from ats2pypre_PYlist_cats import *
#
######
%} // end of [%{^]

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
(* ****** ****** *)
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
staload "./../basics_py.sats"
//
staload "./../SATS/integer.sats"
//
staload "./../SATS/PYlist.sats"
//
(* ****** ****** *)
//
staload "./../SATS/arrayref.sats"
//
(* ****** ****** *)
//
#include
  "{$LIBATSCC}/DATS/arrayref.dats"
//
(* ****** ****** *)
//
(*
assume array(a, n) = PYlist(a)
*)
//
(* ****** ****** *)
//
implement
arrayref_make_elt
  {a}{n}(asz, x0) =
  $UN.cast{arrayref(a,n)}(PYlist_make_elt(asz, x0))
//
(* ****** ****** *)

implement
arrayref_get_at{a}(A, i) = let
  val A = $UN.cast{PYlist(a)}(A) in PYlist_get_at(A, i)
end // end of [arrayref_get_at]

(* ****** ****** *)

implement
arrayref_set_at{a}(A, i, x) = let
  val A = $UN.cast{PYlist(a)}(A) in PYlist_set_at(A, i, x)
end // end of [arrayref_set_at]

(* ****** ****** *)
//
// Array-with-size
//
(* ****** ****** *)
//
implement
arrszref_make_arrayref
  {a}(A, n) = $UN.cast{arrszref(a)}(A)
//
(* ****** ****** *)
//
implement
arrszref_size{a}(A) = let
  val A = $UN.cast{PYlist(a)}(A)
in
  $UN.cast{intGte(0)}(PYlist_length(A))
end // end of [arrszref_size]
//
(* ****** ****** *)
//
implement
arrszref_get_at{a}(A, i) = let
  val A = $UN.cast{PYlist(a)}(A) in PYlist_get_at(A, i)
end // end of [arrszref_get_at]
//
implement
arrszref_set_at{a}(A, i, x) = let
  val A = $UN.cast{PYlist(a)}(A) in PYlist_set_at(A, i, x)
end // end of [arrszref_set_at]
//
(* ****** ****** *)

(* end of [arrayref.dats] *)
