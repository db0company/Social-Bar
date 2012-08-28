(* ************************************************************************** *)
(* Project: Social Bar                                                        *)
(* Description: Module to display a social bar for social networks            *)
(* Author: db0 (db0company@gmail.com, http://db0.fr/)                         *)
(* Latest Version is on GitHub: https://github.com/db0company/Social-Bar      *)
(* ************************************************************************** *)

open Eliom_content
open Html5.D
open Eliom_parameter

let create ~url:url () =
  div
    [Facebook.button url;
     Twitter.button
       ()]
