(* ************************************************************************** *)
(* Project: Facebook for Social Bar                                           *)
(* Description: Module to display a Facebook like button on your website      *)
(* Author: db0 (db0company@gmail.com, http://db0.fr/)                         *)
(* Latest Version is on GitHub: https://github.com/db0company/Social-Bar      *)
(* ************************************************************************** *)

open Eliom_content
open Html5.D

(* ************************************************************************** *)
(* Text of the button                                                         *)
(* ************************************************************************** *)

type text =
  | Recommend
  | Like

let text_str = function
  | Recommend -> "recommend"
  | Like      -> "like"

(* ************************************************************************** *)
(* Layout of the button                                                       *)
(* ************************************************************************** *)

type layout =
  | Standard
  | Button_count
  | Box_count

let layout_str = function
  | Standard     -> "standard"
  | Button_count -> "button_count"
  | Box_count    -> "box_count"

let layout_min_width text = function
  | Standard     ->
    (match text with
      | Recommend -> 265
      | Like      -> 225)
  | Button_count -> 90
  | Box_count    -> 55

let layout_min_height show_faces = function
  | Standard     ->
    (match show_faces with
      | false -> 35
      | true  -> 80)
  | Button_count -> 20
  | Box_count    -> 65

(* ************************************************************************** *)
(* Background style of the button                                             *)
(* ************************************************************************** *)

type background =
  | Dark
  | Light

let background_str = function
  | Dark  -> "dark"
  | Light -> "light"

(* ************************************************************************** *)
(* Font of the button                                                         *)
(* ************************************************************************** *)

type font =
  | Arial
  | LucidaGrande
  | SegoeUI
  | Tahoma
  | TrebuchetMS
  | Verdana

let font_str = function
  | Arial        -> "arial"
  | LucidaGrande -> "lucida+grande"
  | SegoeUI      -> "segoe+ui"
  | Tahoma       -> "tahoma"
  | TrebuchetMS  -> "trebuchet+ms"
  | Verdana      -> "verdana"

(* ************************************************************************** *)
(* Button                                                                     *)
(* ************************************************************************** *)

let button
  ?layout_style:(layout_style=Standard)
  ?width:(pre_width=0)
  ?height:(pre_height=0)
  ?show_faces:(show_faces=false)
  ?text:(text=Like)
  ?background:(background=Light)
  ?font:(font=Arial)
  url =

  let min_width = layout_min_width text layout_style
  and min_height = layout_min_height show_faces layout_style in

  let width = string_of_int
    (if pre_width > 0
     then
	if pre_width < min_width
	then raise (Invalid_argument "width")
	else pre_width
     else min_width)

  and height = string_of_int
    (if pre_height > 0
     then
	if pre_height < min_height
	then raise (Invalid_argument "height")
	else pre_height
     else min_height) in

    let src = "//www.facebook.com/plugins/like.php" ^
      "?href=" ^ (Ocsigen_lib.Url.encode url) ^
      "&send=&layout=" ^ (layout_str layout_style) ^
      "&width=" ^ width ^
      "&show_faces=" ^ (string_of_bool show_faces) ^
      "&action=" ^ (text_str text) ^
      "&colorscheme=" ^ (background_str background) ^
      "&font=" ^ (font_str font) ^
      "&height=" ^ height
    and style = "width:" ^ (width) ^ "px;height:" ^ height ^
      "px;overflow:hidden;border:none;" in

    iframe
      ~a:[a_src (Xml.uri_of_string src);
	  a_style style]
      [pcdata ""]
