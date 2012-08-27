#!/bin/bash
## ########################################################################## ##
## Project: Social Bar                                                        ##
## Description: Installation script                                           ##
## Author: db0 (db0company@gmail.com, http://db0.fr/)                         ##
## Latest Version is on GitHub: https://github.com/db0company/Social-Bar      ##
## ########################################################################## ##

conf_file='example.conf'

function	edit_conf_file() {
    file=$1
    default_port=8080
    default_tmp_path='/tmp'
    pwd=`pwd | sed 's#\/#\\\/#g'`

    if [ -e $file.bak ]
    then mv $file.bak $file
    fi

    cp $file $file.bak && \

	echo -n "Port number ("$default_port")? " && \
	read port && \
	if [ -z $port ]
         then sed -i".tmp" 's/\$PORT/'$default_port'/' $file
         else sed -i".tmp" 's/\$PORT/'$port'/' $file
        fi && \

	echo -n "Temporary directory ("$default_tmp_path")? " && \
	read logdir && \
        if [ -z $logdir ]
	 then
	    logdir=`echo $default_tmp_path | sed 's#\/#\\\/#g'`
	 else
	    logdir=`echo $logdir | sed 's#\/#\\\/#g'`
	fi && \
	sed -i".tmp" 's/\$LOGDIR/'$logdir'/' $file && \
	sed -i".tmp" 's/\$PWD/'$pwd'/' $file && \
	rm *.tmp && \
	return 0
    return 1
}

echo "Install Modules... " && \
    echo "Done." && \

    echo -n "Generate configuration file to test the example (Y/n)? " && \
    read answer && \
    if [ -z "$answer" ]||[ $answer == "y" ]||[ $answer == 'Y' ]
    then
	echo "Edit configuration file... " && \
	    edit_conf_file $conf_file && \
	    echo "Done." && \

	    echo "Social Bar module and its example have been correctly installed. Now you can:" && \
	    echo "- Compile the example using \"make\"." && \
	    echo "- Launch the server for the example using \"ocsigenserver -c "$conf_file"\"" && \
	    echo "- Open the example website on your browser " && \
	    echo "- Use Social Bar for your own Ocsigen Website!"
    else
	    echo -n "Social Bar module have been correctly installed. " && \
		echo "Now you can use Social Bar for your own Ocsigen Website!"
    fi


