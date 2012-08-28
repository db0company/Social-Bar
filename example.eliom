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
      let url = "http://ocsigen.org/"
      and twitter_account = "ocsigen" in
      Lwt.return
        (html
	   (head (title (pcdata "Ocsigen Social Bar Module"))
	      [css_link ~uri:css_uri ()])
           (body [
	     h1 ~a:[a_style "text-align:center;"]
	       [pcdata "Ocsigen Social Bar Module"];

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
		     
		     h5 [pcdata "Dark, count, recommend, trebuchet MS button"];
		     Facebook.button
		       ~background:Facebook.Dark
		       ~text:Facebook.Recommend
		       ~layout_style:Facebook.Box_count
		       ~font:Facebook.TrebuchetMS
		       url;
		   ];
		 div ~a:[a_class ["span3"; "well"]]
		   [
		     h3 [pcdata "Twitter button example"];

		     h5 [pcdata "Simple default button"];
		     Twitter.button ();

		     h5 [pcdata "No counter button with hashtag"];
		     Twitter.button
		       ~count_position:Twitter.None
		       ~url:url
		       ~twitter_account:twitter_account
		       ~hashtags:["Ocsigen"]
		       ();


		     h5 [pcdata
			    ("With a given text, related to some other " ^
				"accounts, count button is displayed on top, " ^
				"some hashtags provided, large button")];
		     Twitter.button
		       ~url:url
		       ~twitter_account:twitter_account
		       ~text:"You should try this powerful web framework!"
		       ~related_twitter_accounts:
		       [("OCamlPro", "develops tools for OCaml");
			("db0company", "the author of this twitter button")]
		       ~count_position:Twitter.Vertical
		       ~hashtags:["OCaml"; "web"; "framework"]
		       ();

		     h5 [pcdata "Large buttons"];
		     Twitter.button
		       ~count_position:Twitter.None
		       ~button_size:Twitter.Large
		       ();
		     Twitter.button
		       ~count_position:Twitter.Horizontal
		       ~button_size:Twitter.Large
		       ();
		   ];
		 div ~a:[a_class ["span3"; "well"]]
		   [
		     h3 [pcdata "Google+ button example"];
		   ];
		 div ~a:[a_class ["span3"; "well"]]
		   [
		     h3 [pcdata "Social Bar example"];
		     Socialbar.create ~url:url ();

		   ]
	       ]
	   ])))
