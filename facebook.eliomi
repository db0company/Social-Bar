(* ************************************************************************** *)
(* Project: Facebook for Social Bar                                           *)
(* Description: Module to display a Facebook like button on your website      *)
(* Author: db0 (db0company@gmail.com, http://db0.fr/)                         *)
(* Latest Version is on GitHub: https://github.com/db0company/Social-Bar      *)
(* ************************************************************************** *)

open Eliom_content
open Html5.D

type text =
  | Recommend
  | Like

type layout =
  | Standard
  | Button_count
  | Box_count

type background =
  | Dark
  | Light

type font =
  | Arial
  | LucidaGrande
  | SegoeUI
  | Tahoma
  | TrebuchetMS
  | Verdana

(* Take the url and some optional parameters and return an iframe containing  *)
(* the Facebook famous "Like" button                                          *)
(* This function can raise Invalid_argument if width or height are too small  *)
val button :
  ?layout_style:layout -> ?width:int -> ?height:int ->
  ?show_faces:bool -> ?text:text -> ?background:background ->
  ?font:font -> string -> [> `Iframe ] Eliom_content.Html5.D.elt
