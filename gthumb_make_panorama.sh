# Custom Command to put into gthumb
# mkdir -p /tmp/gthumb-make-panorama && cp %F /tmp/gthumb-make-panorama && paplay /usr/share/sounds/freedesktop/stereo/complete.oga & sh /usr/local/bin/gthumb_make_panorama.sh %P


if hash pto_gen 2>/dev/null; then

	# Create a Folder in /tmp and cd into it
	mkdir /tmp/gthumb-make-panorama
	cd /tmp/gthumb-make-panorama
	
	# Set A Variabel for a Unique FolderName
	NOW=$(date +"%Y-%m-%d %H:%M:%S")
	# Create that Folder
	mkdir "$NOW"
	# Move all the Pictures into that Folder
	mv *.* "$NOW"
	# cd into that Folder
	cd "$NOW"


	# Start with the creation of the Panorama
	# source / credits : http://wiki.panotools.org/Panorama_scripting_in_a_nutshell#Why_would_you_do_that.3F

	nice -n 19 pto_gen * -o project.pto

	nice -n 19 cpfind --multirow -o project.pto project.pto

	nice -n 19 celeste_standalone -i project.pto -o project.pto

	# not working
	# ptoclean -v --output project.pto project.pto

	nice -n 19 autooptimiser -a -l -s -o project.pto project.pto

	nice -n 19 pano_modify -o project.pto --center --straighten --canvas=AUTO --crop=AUTO project.pto

	nice -n 19 nona -m TIFF_m -o project project.pto

	nice -n 19 enblend -o project.jpg *.tif

	# Copy the Finished Panorama Back to the Original Path of the Pictures.
	cp project.jpg "$1"/panorama-"$NOW".jpg

	notify-send 'Panorama Finished' 'Check it out!' -u normal -i "$1"/panorama-"$NOW".jpg

	# Delete our Temporary Workfolder
	rm -rf ../"$NOW"
	
else
	echo ERROR: Could not find hugin >&2
	echo hugin needs to installed and in standardpath for make_panorama to work >&2
		
	notify-send 'ERROR: Could not find hugin' 'hugin needs to installed and in standardpath for make_panorama to work!
	> Please install it and try again.' -u critical -i face-worried
	# delete the Copied Files
	rm /tmp/gthumb-make-panorama/*.*
fi
