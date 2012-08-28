(* ************************************************************************** *)
(* Project: Twitter for Social Bar                                            *)
(* Description: Module to display a Twitter button on your website            *)
(* Author: db0 (db0company@gmail.com, http://db0.fr/)                         *)
(* Latest Version is on GitHub: https://github.com/db0company/Social-Bar      *)
(* ************************************************************************** *)

open Eliom_content
open Html5.D
open Eliom_parameter

(* ************************************************************************** *)
(* Button count position                                                      *)
(* ************************************************************************** *)

type count_position =
  | Default_position
  | None
  | Horizontal
  | Vertical

let count_position_str = function
  | Default_position -> ""
  | None             -> "none"
  | Horizontal       -> "horizontal"
  | Vertical         -> "vertical"

(* ************************************************************************** *)
(* Button size                                                                *)
(* ************************************************************************** *)

type button_size =
  | Default_size
  | Medium
  | Large

let button_size_str = function
  | Default_size -> ""
  | Medium       -> "m"
  | Large        -> "l"

(* ************************************************************************** *)
(* Minimum width&height checker                                               *)
(* ************************************************************************** *)

let button_min_width size = function
  | None     -> (match size with Large ->  77 | _ ->  59)
  | Vertical -> (match size with Large ->  77 | _ ->  59)
  | _        -> (match size with Large -> 144 | _ -> 110)

let button_min_height size = function
  | None     -> (match size with Large ->  28 | _ ->  20)
  | Vertical -> (match size with Large ->  28 | _ ->  62)
  | _        -> (match size with Large ->  28 | _ ->  20)

(* ************************************************************************** *)
(* Button                                                                     *)
(* ************************************************************************** *)

(* Take some optional parameters and return an iframe containing the twitter  *)
(* button to share the url, with a counter of tweets                          *)
(* This function can raise Invalid_argument if width or height are too small  *)
let button
    ?width:(pre_width=0)
    ?height:(pre_height=0)
    ?text:(text="")
    ?related_twitter_accounts:(related=[])
    ?count_position:(count_position=Default_position)
    ?hashtags:(hashtags=[])
    ?button_size:(size=Default_size)
    ?lang:(lang="")
    ?url:(url="")
    ?twitter_account:(account="")
    () =

  let min_width = button_min_width size count_position
  and min_height = button_min_height size count_position in

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

  let related_str =
    List.fold_left
      (fun str (name, descr) -> str ^ name ^ ":" ^ descr ^ ",")
      "" related in

  let twitter_url =
(* Note: The Url is not generated using a service because empty parameters    *)
(*       are taken into account by the twitter button api, so this method,    *)
(*       using a string, is dirty but avoir empty parameters.                 *)
    List.fold_left
    (fun url (key, value) ->
      if (String.length value) = 0
      then url
      else url ^ key ^ "=" ^ value ^ "&")
      "https://platform.twitter.com/widgets/tweet_button.html?"
      [("url", Ocsigen_lib.Url.encode url);
       ("via", account);
       ("text", text);
       ("related", related_str);
       ("count", count_position_str count_position);
       ("hashtags", String.concat "," hashtags);
       ("size", button_size_str size);
       ("lang", lang);
      ]

  and style =
    "width:" ^ width ^ "px;" ^
      "height:" ^ height ^ "px;" ^
      "overflow:hidden;" ^
      "border:none;" in

  iframe
    ~a:[a_src (Xml.uri_of_string twitter_url); a_style style] [pcdata ""]

