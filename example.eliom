(* ************************************************************************** *)
(* Project: Social Bar                                                        *)
(* Description: Example of usage of the module Social Bar (socialbar.eliom)   *)
(* Author: db0 (db0company@gmail.com, http://db0.fr/)                         *)
(* Latest Version is on GitHub: https://github.com/db0company/Social-Bar      *)
(* ************************************************************************** *)

open Eliom_content
open Html5.D
open Eliom_parameter

module Example_app =
  Eliom_registration.App
    (struct
      let application_name = "socialbar"
     end)

let main_service =
  Eliom_service.service
    ~path:[""]
    ~get_params:unit
    ()

let css_uri =
  Xml.uri_of_string
    "http://twitter.github.com/bootstrap/assets/css/bootstrap.css"

let _ = 
  Example_app.register
    ~service:main_service
    (fun () () ->
      let url = "http://ocsigen.org/" in
      Lwt.return
        (html
	   (head (title (pcdata "Ocsigen Social Bar Module"))
	      [css_link ~uri:css_uri ()])
           (body [
	     h1 ~a:[a_style "text-align:center;"] [pcdata "Ocsigen Social Bar Module"];

	     div ~a:[a_class ["row-fluid"]]
	       [
		 div ~a:[a_class ["span3"; "well"]]
		   [
		     h3 [pcdata "Facebook button examples"];

		     h5 [pcdata "Simple default button"];
		     Facebook.button url;

		     h5 [pcdata "Count, dark, verdana button"];
		     Facebook.button
		       ~layout_style:Facebook.Button_count
		       ~background:Facebook.Dark
		       ~font:Facebook.Verdana
		       url;
		     
		     h5 [pcdata "Huge Box count, dark, recommend, trebuchet MS button"];
		     Facebook.button
		       ~width:300
		       ~height:400
		       ~background:Facebook.Dark
		       ~text:Facebook.Recommend
		       ~layout_style:Facebook.Box_count
		       ~font:Facebook.TrebuchetMS
		       url;
		   ];
		 div ~a:[a_class ["span3"; "well"]]
		   [
		     h3 [pcdata "Twitter button example"];
		   ];
		 div ~a:[a_class ["span3"; "well"]]
		   [
		     h3 [pcdata "Google+ button example"];
		   ];
		 div ~a:[a_class ["span3"; "well"]]
		   [
		     h3 [pcdata "Social Bar example"];
		     Socialbar.create url;

		   ]
	       ]
	   ])))
