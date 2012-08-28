(* ************************************************************************** *)
(* Project: Twitter for Social Bar                                            *)
(* Description: Module to display a Twitter button on your website            *)
(* Author: db0 (db0company@gmail.com, http://db0.fr/)                         *)
(* Latest Version is on GitHub: https://github.com/db0company/Social-Bar      *)
(* ************************************************************************** *)

open Eliom_content
open Html5.D

type count_position =
  | Default_position
  | None
  | Horizontal
  | Vertical

type button_size =
  | Default_size
  | Medium
  | Large

(* Take some optional parameters and return an iframe containing the twitter  *)
(* button to share the url, with a counter of tweets                          *)
(* The list of twitter accounts contains pairs of (name * description)        *)
(* This function can raise Invalid_argument if width or height are too small  *)
val button :
  ?width:int -> ?height:int -> ?text:string ->
  ?related_twitter_accounts:((string * string) list) ->
  ?count_position:count_position -> ?hashtags:(string list) ->
  ?button_size:button_size -> ?lang:string -> ?url:string ->
  ?twitter_account:string -> unit -> [> `Iframe ] Eliom_content.Html5.D.elt
